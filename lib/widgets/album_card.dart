import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/constants/constants.dart';
import '../main.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({required this.index, super.key, required this.ref});

  final int index;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(context, Constants.nowPlaying, Constants.albumList[index]);
        ref.watch(currentlyPlaying.notifier).current(Constants.albumList[index]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shadowColor: const Color(0xff866684),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              height: 110,
              width: Constants.wrapWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black45,
                image: DecorationImage(image: Utils.buildExactAssetImage(index), fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Constants.wrapWidth.spaceX(Text(
              overflow: TextOverflow.ellipsis,
              Constants.albumList[index].title!,
              style: TextStyle(fontSize: 16, color: Colors.white.withAlpha(190)),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Constants.wrapWidth.spaceX(Text(
              softWrap: true,
              Constants.albumList[index].artiste!.name,
              style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(100)),
            )),
          ),
        ],
      ),
    );
  }
}
