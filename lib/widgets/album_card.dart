import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ost_music_app_ui/routes/now_playing.dart';

import '../data/constants/constants.dart';
import '../utils/utils.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    required this.index,
    super.key,
    /*required this.ref*/
  });

  final int index;

  //final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //launch(context, Constants.nowPlaying, Constants.albumList[index]);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NowPlaying(),
            settings: RouteSettings(name: 'album', arguments: Constants.albumList[index]),
          ),
        );
        //ref.watch(currentlyPlaying.notifier).current(Constants.albumList[index]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shadowColor: const Color(0xff866684),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12).r),
            child: Container(
              height: 110.h,
              width: Constants.wrapWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12).r,
                color: Colors.black45,
                image: DecorationImage(image: Utils.buildExactAssetImage(index), fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Constants.wrapWidth.spaceX(Text(
              overflow: TextOverflow.ellipsis,
              Constants.albumList[index].title!,
              style: TextStyle(fontSize: 16.h, color: Colors.white.withAlpha(190)),
            )),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Constants.wrapWidth.spaceX(Text(
              softWrap: true,
              Constants.albumList[index].artiste!.name,
              style: TextStyle(fontSize: 12.h, color: Colors.white.withAlpha(100)),
            )),
          ),
        ],
      ),
    );
  }
}
