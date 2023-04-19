import 'dart:developer';
import 'dart:ui';

import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ost_music_app_ui/data/constants/constants.dart';
import 'package:ost_music_app_ui/data/models/album.dart';

import '../main.dart';
import '../providers/providers.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController rotationController;
  late Album album;
  late ImageProvider imageProvider;
  final List<Album> albumList = Constants.albumList;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 30));
    rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 30));
    controller.addListener(() {
      setState(() {});
    });
    startControllers();
  }

  @override
  void dispose() {
    controller.dispose();
    rotationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    album = GoRouterState.of(context).extra as Album;
    imageProvider = ExactAssetImage(album.image!);
    precacheImage(imageProvider, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final limit = albumList.length - 1;
    var currentSong = albumList.indexOf(album);
    var nextSong = currentSong != limit ? albumList[currentSong + 1] : albumList[0];
    var previousSong = currentSong != 0 ? albumList[currentSong - 1] : albumList[limit];
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
      padding: const EdgeInsets.only(top: 56, bottom: 46, right: 20, left: 20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: [
                ///ROW 1
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  GestureDetector(onTap: () => finish(context), child: const Icon(CupertinoIcons.chevron_down, color: Colors.white)),
                  GestureDetector(onTap: () {}, child: const Icon(CupertinoIcons.ellipsis, color: Colors.white)),
                ]),
                35.spaceY(),

                /// Song Title
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  album.title!,
                  style: const TextStyle(fontSize: 28, color: Colors.white, fontStyle: FontStyle.normal),
                ),
                //const Text('We Need Our Army Back', style: TextStyle(fontSize: 28, color: Colors.white, fontStyle: FontStyle.normal)),
                10.spaceY(),

                /// Artist Name
                Text(album.artiste!.name, style: const TextStyle(fontSize: 16, color: Colors.white)),
                //const Text('Hans Zimmer', style: TextStyle(fontSize: 16, color: Colors.white)),
                35.spaceY(),

                /// Big Card
                RotationTransition(
                  turns: rotationController,
                  child: Card(
                    color: Colors.white.withAlpha(90),
                    elevation: 20,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                  ),
                ),
                50.spaceY(),

                /// Song Progress Indicator
                LinearProgressIndicator(value: controller.value),
                10.spaceY(),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                  Text('2:49', style: TextStyle(fontSize: 12, color: Colors.white)),
                  Text('6:28', style: TextStyle(fontSize: 12, color: Colors.white)),
                ]),

                /// Music Control Buttons
                Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  bool isPlay = ref.watch(playProvider.select((value) => value));
                  isPlay ? controller.repeat() : controller.stop(canceled: false);
                  isPlay ? rotationController.repeat() : rotationController.stop(canceled: false);
                  log('Playing: $isPlay : ${controller.value}');

                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      GestureDetector(
                        onTap: () {
                          stopControllers();
                          replace(context, Constants.nowPlaying, previousSong);
                          startControllers();
                          ref.watch(playProvider.notifier).play(true);
                          ref.watch(currentlyPlaying.notifier).current(nextSong);
                        },
                        child: const Icon(CupertinoIcons.backward_fill, color: Colors.white, size: 35),
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.watch(playProvider.notifier).play(!isPlay);
                        },
                        child: Icon(
                          isPlay ? CupertinoIcons.pause_fill : CupertinoIcons.play_fill,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          stopControllers();
                          replace(context, Constants.nowPlaying, nextSong);
                          startControllers();
                          ref.watch(playProvider.notifier).play(true);
                          ref.watch(currentlyPlaying.notifier).current(nextSong);
                        },
                        child: const Icon(CupertinoIcons.forward_fill, color: Colors.white, size: 35),
                      ),
                    ]),
                  );
                }),

                20.spaceY(),

                /// Last Row
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(CupertinoIcons.repeat, color: Colors.white.withOpacity(0.6)),
                        GestureDetector(
                          onTap: () {
                            ref.watch(isLiked.notifier).like(!ref.watch(isLiked.select((value) => value)));
                          },
                          child: ref.watch(isLiked.select((value) => value))
                              ? Icon(CupertinoIcons.heart_fill, color: Colors.white.withOpacity(0.6))
                              : Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                        ),
                        Icon(CupertinoIcons.down_arrow, color: Colors.white.withOpacity(0.6)),
                        Icon(CupertinoIcons.text_bubble, color: Colors.white.withOpacity(0.6)),
                        GestureDetector(onTap: () => launchReplace(context, Constants.playlist, album), child: Icon(CupertinoIcons.music_note_list, color: Colors.white.withOpacity(0.6))),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startControllers() {
    controller.repeat();
    rotationController.repeat();
  }

  void stopControllers() {
    controller.reset();
    rotationController.reset();
  }
}
