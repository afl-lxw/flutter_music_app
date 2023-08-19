import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_music_app/data/color.dart';
import 'package:flutter_music_app/data/images.dart';
import 'package:flutter_music_app/provider/musicStatus.dart';
import 'package:flutter_music_app/widget/myClipper.dart';
import 'package:flutter_music_app/widget/play/playContainer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () => {
              // Navigator.of(context).push(_createRoute())
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return PlayContainerWidget();
                },
              )
            },
        child: ClipPath(
          clipper: MyClipper(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
              width: displayWidth,
              height: 65,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ]),
              child: _PlayRow(context)),
        ));
  }

  Row _PlayRow(BuildContext context) {
    final musicStatus = Provider.of<MusicStatus>(context);

    return Row(children: [
      Hero(
          transitionOnUserGestures: true,
          tag: 'playImg',
          // flightShuttleBuilder: (BuildContext flightContext,
          //     Animation<double> animation,
          //     HeroFlightDirection flightDirection,
          //     BuildContext fromHeroContext,
          //     BuildContext toHeroContext) {
          //   // 创建自定义过渡的 widget
          //   return FadeTransition(
          //       opacity: animation,
          //       child: Container(
          //         width: 100,
          //         height: 100,
          //         color: Colors.transparent, // 使用透明背景色
          //       ));
          // },
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 1), // 垂直偏移
                  blurRadius: 5, // 模糊半径
                  spreadRadius: 0, // 扩散半径
                ),
              ],
              image: DecorationImage(image: AssetImage(userImg)),
            ),
          )),
      const SizedBox(width: 10),
      const Expanded(
          child: Hero(
        tag: 'PlayName',
        child: Text(
          'Black Magic',
          style: TextStyle(
            color: tFontColor,
          ),
        ),
      )),
      GestureDetector(
          onTap: () {
            musicStatus
                .setNewStatus(musicStatus.getStatus == 'on' ? 'off' : 'on');
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: Hero(
                tag: 'play',
                child: Icon(
                  key: ValueKey<String>(musicStatus.getStatus),
                  musicStatus.getStatus == 'on'
                      ? FontAwesomeIcons.play
                      : FontAwesomeIcons.pause,
                  color: tFontColor,
                )),
          )),
      const SizedBox(width: 15),
      const Hero(
          tag: 'next',
          child: Icon(
            FontAwesomeIcons.forward,
            color: tFontColor,
          )),
      const SizedBox(width: 5),
    ]);
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return PlayContainerWidget();
    },
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1), // 从底部往上弹出
          end: Offset.zero,
        ).animate(animation),
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      );
    },
  );
}
