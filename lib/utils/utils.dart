import 'dart:developer';

import 'package:flutter/material.dart';

import '../data/constants/constants.dart';

class Utils {
  Utils._();

  static ExactAssetImage buildExactAssetImage(int index) => ExactAssetImage(Constants.albumList[index].image!);

  static Type check<T>(bool b, Function(T) callback) {
    return T;
  }

  static bool isNull(Object? object) => object == null;

  static LinearGradient buildGradient() => const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
        //Color(0xff3281f5),
        //Colors.lightBlue,
        //Color(0xff03A9F4),
        Color(0xff0283bd),
        //Color(0xff658abc),
        Color(0xff658abc),
        //Color(0xff5a84c0),
        //Color(0xff896785),
        Color(0xff866684),
        Color(0xff585070),
        Color(0xff595273),
      ]);

}
