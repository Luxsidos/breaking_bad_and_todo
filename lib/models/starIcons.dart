import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarIcons {
  static List<Widget> starIcon() {
    List<Widget> iconList = [];
    for (int i = 0; i < 5; i += 1) {
      iconList.add(Icon(
        CupertinoIcons.star_fill,
        color: Colors.yellow.shade700,
        size: 12.0,
      ));
    }
    return iconList;
  }
}
