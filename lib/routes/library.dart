import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ost_music_app_ui/data/constants/constants.dart';
import 'package:ost_music_app_ui/utils/page.dart';

import '../main.dart';
import '../utils/utils.dart';
import '../widgets/album_card.dart';
import '../widgets/artist_card.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/painter.dart';

class Library extends ConsumerStatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  ConsumerState<Library> createState() => _LibraryState();
}

class _LibraryState extends ConsumerState<Library> {
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < Constants.albumList.length; ++i) {
      ExactAssetImage(Constants.albumList[i].image!);
    }
  }

  @override
  void didChangeDependencies() {
    for (var i = 0; i < Constants.albumList.length; ++i) {
      precacheImage(Utils.buildExactAssetImage(i), context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: Utils.buildGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                80.spaceY(),

                /// Row 1 --- Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Library', style: TextStyle(fontSize: 32, color: Colors.white.withOpacity(0.9))),
                    Icon(CupertinoIcons.bell, color: Colors.white.withOpacity(0.7)),
                  ]),
                ),

                15.spaceY(),

                /// Row 2 --- Slacker Radio
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  /*foregroundDecoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),*/
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(blurRadius: 2, color: Colors.grey)],
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(opacity: 0.2, fit: BoxFit.cover, image: ExactAssetImage(Constants.wave)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 12, left: 18),
                            child: Icon(CupertinoIcons.play_circle, color: Colors.black, size: 38),
                          ),
                          Text('Slacker Radio', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Icon(CupertinoIcons.music_note_list, color: Colors.black, size: 22),
                      ),
                    ]),
                  ),
                ),
                30.spaceY(),

                /// Row 3 --- Local, Recent, Offline
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  color: Colors.transparent,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(
                      children: [
                        const Icon(CupertinoIcons.folder, size: 30, color: Colors.white),
                        10.spaceY(),
                        const Text('Local', style: TextStyle()),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => launch(context, Constants.discover),
                      child: Column(
                        children: [
                          const Icon(CupertinoIcons.clock, size: 30, color: Colors.white),
                          10.spaceY(),
                          const Text('Recent', style: TextStyle()),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const Icon(CupertinoIcons.wifi_slash, size: 30, color: Colors.white),
                        10.spaceY(),
                        const Text('Offline', style: TextStyle()),
                      ],
                    ),
                  ]),
                ),
                40.spaceY(),

                /// Row 4 --- Favourite Albums
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: CustomPaint(painter: Line()),
                        ),
                        10.spaceX(),
                        const Text('Favourite Albums', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                      ],
                    ),
                    Icon(CupertinoIcons.forward, color: Colors.white.withOpacity(0.6))
                  ]),
                ),

                25.spaceY(),

                /// Horizontal List
                158.spaceY(
                  ListView.builder(
                    shrinkWrap: true,
                    itemExtent: 115,
                    itemCount: Constants.albumList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return AlbumCard(index: index, ref: ref);
                    },
                  ),
                ),

                30.spaceY(),

                ///Row 5 --- Collection of Artist
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: CustomPaint(painter: Line()),
                        ),
                        10.spaceX(),
                        const Text('Collection of Artist', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                      ],
                    ),
                    Icon(CupertinoIcons.forward, color: Colors.white.withOpacity(0.6))
                  ]),
                ),

                20.spaceY(),

                /// Horizontal List
                155.spaceY(
                  ListView.builder(
                    shrinkWrap: true,
                    itemExtent: 115,
                    itemCount: Constants.artisteList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return ArtistCard(index: index);
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNav(context: context, ref: ref,page: NavPage.library),
      ),
    );
  }

}
