import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/material.dart';

import '../data/constants/constants.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          shadowColor: const Color(0xff866684),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 115,
            width: Constants.wrapWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black45,
              image: DecorationImage(image: ExactAssetImage(Constants.artisteList[index].image), fit: BoxFit.cover),
            ),
          ),
        ),
        Constants.wrapWidth.spaceX(
          Text(
            overflow: TextOverflow.ellipsis,
            Constants.artisteList[index].name,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
