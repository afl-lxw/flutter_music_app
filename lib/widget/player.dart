import 'dart:ui';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_app/data/color.dart';
import 'package:flutter_music_app/data/images.dart';
import 'package:flutter_music_app/widget/myClipper.dart';
import 'package:flutter_music_app/widget/play/playContainer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_music_app/getx/music/musicStatus.dart';
import 'package:get/get.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  late dynamic duration;
  final AudioPlayer player = AudioPlayer();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;

    return GetBuilder<MusicStatusX>(builder: (musicStatusx) {
      // return Obx(() {
      return _guestureSelf(context, displayWidth, musicStatusx);
      // });
    });
  }

  GestureDetector _guestureSelf(
      BuildContext context, double displayWidth, MusicStatusX musicStatusx) {
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
              child: _PlayRow(context, musicStatusx)),
        ));
  }

  Row _PlayRow(BuildContext context, MusicStatusX musicStatusx) {
    // final musicStatus = Provider.of<MusicStatus>(context);

    final controller = Get.find<MusicStatusX>();
    final getMusicInfo = controller.getMusicInfo;

    return Row(children: [
      Hero(
          transitionOnUserGestures: true,
          tag: 'playImg',
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
              image: DecorationImage(
                  image: AssetImage('${getMusicInfo['imgAvatar']}')),
            ),
          )),
      const SizedBox(width: 10),
      Expanded(
          child: Hero(
        tag: 'PlayName',
        child: Text(
          '${getMusicInfo['musicName']}-- ${controller.getPlayStatus.value}',
          style: const TextStyle(
            color: tFontColor,
          ),
        ),
      )),
      GestureDetector(
          onTap: () async {
            print(
                'musicStatusx.getStatus----${controller.getPlayStatus.value}');
            if (!controller.getPlayStatus.value) {
              controller.play();
            } else {
              controller.pause();
            }
          },
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child:
                  //  Hero(
                  //     tag: 'play',
                  //     child:
                  Icon(
                key: ValueKey<bool>(musicStatusx.getPlayStatus.value),
                musicStatusx.getPlayStatus.value == true
                    ? FontAwesomeIcons.pause
                    : FontAwesomeIcons.play,
                color: tFontColor,
              )
              // ),
              )),
      const SizedBox(width: 15),
      GestureDetector(
        onTap: () {
          musicStatusx.playNext();
        },
        child: const Hero(
            tag: 'next',
            child: Icon(
              FontAwesomeIcons.forward,
              color: tFontColor,
            )),
      ),
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
