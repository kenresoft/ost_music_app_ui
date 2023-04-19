import 'dart:ui';

import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ost_music_app_ui/data/constants/constants.dart';

import '../data/models/album.dart';
import '../main.dart';
import '../providers/providers.dart';
import '../utils/page.dart';
import '../widgets/bottom_nav.dart';

class Playlist extends ConsumerStatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  ConsumerState<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends ConsumerState<Playlist> {
  late Album album;
  late ImageProvider imageProvider;

  @override
  void didChangeDependencies() {
    album = GoRouterState.of(context).extra as Album;
    imageProvider = ExactAssetImage(album.image!);
    precacheImage(imageProvider, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        padding: const EdgeInsets.only(top: 56, bottom: 3),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
          child: Column(
            children: [
              ///ROW 1
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  onTap: () => replace(context, Constants.nowPlaying),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10, bottom: 10, left: 25),
                    child: Icon(CupertinoIcons.chevron_back, color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10, right: 25),
                    child: Icon(Icons.share_outlined, color: Colors.white),
                  ),
                )
              ]),
              15.spaceY(),

              /// ROW 2
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 2,
                      shadowColor: const Color(0xff866684),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black45,
                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    10.spaceX(),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      //Text(softWrap: true, album.title, style: TextStyle(fontSize: 20, color: Colors.white.withAlpha(190))),
                      190.spaceX(Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          'Dunkirk (Original Motion Picture Soundtrack)',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white.withAlpha(190)))),
                      5.spaceY(),
                      Text(album.artiste!.name, style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(150))),
                    ]),
                  ],
                ),
              ),
              15.spaceY(),

              /// Last Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(CupertinoIcons.repeat, color: Colors.white.withOpacity(0.6)),
                    Icon(CupertinoIcons.heart, color: Colors.white.withOpacity(0.6)),
                    Icon(CupertinoIcons.down_arrow, color: Colors.white.withOpacity(0.6)),
                    Icon(CupertinoIcons.text_bubble, color: Colors.white.withOpacity(0.6)),
                    //Icon(CupertinoIcons.music_note_list, color: Colors.white.withOpacity(0.6)),
                  ],
                ),
              ),

              15.spaceY(),

              Divider(color: Colors.grey.withOpacity(0.7), height: 1),

              /// ListView
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemExtent: 60,
                    itemCount: Constants.albumList.length,
                    itemBuilder: (c, index) {
                      return Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return ListTile(
                            onTap: () {
                              replace(context, Constants.nowPlaying, Constants.albumList[index]);
                              ref.watch(currentlyPlaying.notifier).current(Constants.albumList[index]);
                            },
                            minVerticalPadding: 1,
                            horizontalTitleGap: -15,
                            leading: Center(widthFactor: 1, child: Text('${index + 1}', style: TextStyle(color: Colors.white.withAlpha(150)))),
                            title: Text(Constants.albumList[index].title!, style: const TextStyle(color: Colors.white)),
                            subtitle: Text(Constants.albumList[index].artiste!.name, style: TextStyle(color: Colors.white.withAlpha(150))),
                            trailing: Icon(CupertinoIcons.ellipsis, color: Colors.white.withAlpha(200)),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// BottomNavigation
      bottomNavigationBar: CustomBottomNav(context: context, ref: ref, page: NavPage.nowPlaying),
    );
  }
}
