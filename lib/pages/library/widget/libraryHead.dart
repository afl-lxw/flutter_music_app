import 'package:flutter/material.dart';
import 'package:flutter_music_app/data/color.dart';
import 'package:flutter_music_app/data/images.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(
        color: tbgColor,
      ),
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 0),
      child: Row(
        children: [
          const Text(
            'Library',
            style: TextStyle(
                color: tFontColor, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(userImg)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 110.0;

  @override
  double get minExtent => 110.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
