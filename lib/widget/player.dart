import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_music_app/data/color.dart';
import 'package:flutter_music_app/data/images.dart';
import 'package:flutter_music_app/widget/myClipper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      clipper: MyClipper(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
          width: displayWidth,
          height: 65,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage(userImg)),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Black Magic',
              style: TextStyle(
                color: tFontColor,
              ),
            ),
            const Spacer(),
            const Icon(
              FontAwesomeIcons.play,
              color: tFontColor,
            ),
            const SizedBox(width: 15),
            const Icon(
              FontAwesomeIcons.forward,
              color: tFontColor,
            ),
            const SizedBox(width: 5),
          ])),
    );
  }
}
