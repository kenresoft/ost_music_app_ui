import 'package:bottom_nav/bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ost_music_app_ui/data/models/album.dart';
import 'package:ost_music_app_ui/routes/now_playing.dart';

import '../data/constants/constants.dart';
import '../main.dart';
import '../providers/providers.dart';
import '../utils/page.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({Key? key, required this.context, required this.ref, this.page}) : super(key: key);

  final BuildContext context;
  final WidgetRef ref;
  final NavPage? page;

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    Album album = widget.ref.watch(currentlyPlaying.select((value) => value));
    var isLaunched = widget.ref.watch(launchProvider.select((value) => value));
    //Future.delayed(const Duration(seconds: 1), () => widget.ref.watch(launchProvider.notifier).launch(true));
    return Theme(
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: BottomNav(
        divider: Divider(height: 1.h, color: Colors.white.withOpacity(0.3)),
        height: 91.5.h,
        padding: EdgeInsets.only(bottom: 15.h, left: 20.w, right: 20.w),
        onTap: (index) => buildNavSwitch(index, context, widget.ref),
        iconSize: 26.r,
        backgroundColor: const Color(0xff41415f),
        color: const Color(0xff878b9c),
        colorSelected: const Color(0xffe2a5a9),
        //indexSelected: isLaunched ? widget.ref.watch(tabProvider.select((value) => value)) : widget.page!.page,
        indexSelected: widget.page!.page,
        items: [
          const BottomNavItem(label: 'Discover', child: CupertinoIcons.rays),
          const BottomNavItem(label: 'Library', child: CupertinoIcons.tray),
          BottomNavItem(
            label: '',
            child: Card(
              color: Colors.white.withAlpha(200),
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180).r),
              child: Container(
                margin: const EdgeInsets.all(3).r,
                height: 42.h,
                width: 42.h,
                decoration: BoxDecoration(
                  image: DecorationImage(image: ExactAssetImage(album != Album.empty() ? album.image! : Constants.album), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(180).r,
                ),
              ),
            ),
          ),
          const BottomNavItem(label: 'Store', child: CupertinoIcons.shopping_cart),
          const BottomNavItem(label: 'Account', child: CupertinoIcons.person),
        ],
      ),
    );
  }
}

void buildNavSwitch(int index, BuildContext context, WidgetRef ref) {
  var cacheTabIndex = ref.watch(tabProvider.select((value) => value));
  switch (index) {
    case 0:
      //ref.watch(launchProvider.notifier).launch(true);
      if (cacheTabIndex != 0) {
        launchReplace(context, Constants.discover);
        ref.watch(tabProvider.notifier).setTab = index;
      }
      break;
    case 1:
      //ref.watch(launchProvider.notifier).launch(true);
      if (cacheTabIndex != 1) {
        launchReplace(context, Constants.library);
        ref.watch(tabProvider.notifier).setTab = index;
      }
      break;
    case 2:
      if (cacheTabIndex != 2) {
        currentSong(ref).title == null
            ? null
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const NowPlaying();
                  },
                  settings: RouteSettings(name: 'album', arguments: currentSong(ref)),
                ),
              ); /*launchReplace(context, Constants.nowPlaying, currentSong(ref))*/
        ref.watch(tabProvider.notifier).setTab = index;
        //ref.watch(launchProvider.notifier).launch(true);
      }
      break;
    case 3:
      //ref.watch(launchProvider.notifier).launch(true);
      ref.watch(tabProvider.notifier).setTab = index;
      break;
    case 4:
      //ref.watch(launchProvider.notifier).launch(true);
      ref.watch(tabProvider.notifier).setTab = index;
      break;
    default:
      //ref.watch(launchProvider.notifier).launch(true);
      ref.watch(tabProvider.notifier).setTab = index;
  }
}

Album currentSong(WidgetRef ref) => ref.watch(currentlyPlaying.select((value) => value));
