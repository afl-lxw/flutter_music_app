// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_music_app/components/IconWithTapAnimation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:provider/provider.dart';

import 'package:flutter_music_app/data/color.dart';
import 'package:flutter_music_app/data/images.dart';
import 'package:flutter_music_app/getx/music/musicStatus.dart';

class PlayContainerWidget extends StatefulWidget {
  const PlayContainerWidget({
    Key? key,
    // required this.musicStatusX,
  }) : super(key: key);
  // final MusicStatusX musicStatusX;

  @override
  State<PlayContainerWidget> createState() => _PlayContainerWidgetState();
}

class _PlayContainerWidgetState extends State<PlayContainerWidget>
    with SingleTickerProviderStateMixin {
  bool _isLyricsVisible = false;

  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    //启动动画(正向执行)
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double playWidth = MediaQuery.of(context).size.width;
    double playHeight = MediaQuery.of(context).size.height;

    // return AnimatedAlign(
    //   alignment: Alignment.bottomCenter,
    //   duration: Duration(milliseconds: 300),
    //   child: GestureDetector(
    //     onVerticalDragDown: (details) =>
    //         {print('onVerticalDragDown ${details}')},
    //     onVerticalDragUpdate: (details) {
    //       print('primaryDelta ${details.primaryDelta}');
    //       print('localPosition ${details.localPosition}');

    //       // 监听手指垂直滑动事件
    //       if (_isLyricsVisible) {
    //         // 如果歌词区域可见，处理歌词滑动
    //         // 您可以在这里实现歌词滑动的逻辑
    //       } else {
    //         // 如果歌词区域不可见，处理页面返回跳转
    //         if (details.primaryDelta! > 20) {
    //           // 手指向下拖动
    //           Navigator.pop(context);
    //         }
    //       }
    //     },
    //     onVerticalDragEnd: (details) => {print('onVerticalDragEnd ${details}')},
    //     child: _Play_Scaffold(playHeight, playWidth),
    //   ),
    // );

    return DraggableScrollableSheet(
      initialChildSize: 1, // 初始高度占整个屏幕的比例
      minChildSize: 0.8, // 最小高度占整个屏幕的比例
      builder: (BuildContext context, ScrollController scrollController) {
        return GetBuilder<MusicStatusX>(builder: (musicStatusx) {
          return _Play_Scaffold(playHeight, playWidth, musicStatusx);
        });
      },
    );
  }

  Scaffold _Play_Scaffold(
      double playHeight, double playWidth, MusicStatusX musicStatusx) {
    final getMusicInfo = musicStatusx.getMusicInfo;

    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: playHeight,
          width: playWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('${getMusicInfo['imgAvatar']}'),
                  fit: BoxFit.cover)),
        ),
        // Positioned.fill(
        ClipRect(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25), // 模糊效果
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              const Color.fromARGB(255, 65, 65, 65).withOpacity(0.1), // 颜色混合效果
              BlendMode.srcATop,
            ),
            child: Container(
              width: playWidth,
              height: playHeight,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5), // 背景颜色
              ),
            ),
          ),
        )),
        // ),
        Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: playWidth,
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ), // 顶部留白

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                // color: Colors.white.withOpacity(0.2),
                alignment: Alignment.center,
                child: FadeTransition(
                    opacity: _controller,
                    child: Hero(
                      tag: 'playImg',
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 35, 35, 35)
                                  .withOpacity(0.5),
                              spreadRadius: 6,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          // image: DecorationImage(
                          //     colorFilter: ColorFilter.mode(
                          //         Colors.black.withOpacity(0.1),
                          //         BlendMode.srcATop),
                          //     image: AssetImage(
                          //         '${getMusicInfo['imgAvatar']}'))
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            '${getMusicInfo['imgAvatar']}',
                            width: 280,
                            height: 280,
                            fit: BoxFit.cover, // 使用 BoxFit.cover 实现图片适应并撑满容器
                            alignment: Alignment.center, // 图片居中显示
                            colorBlendMode: BlendMode.srcATop, // 混合模式
                            // color: Colors.black.withOpacity(0.1), // 颜色滤镜
                          ),
                        ),
                      ),
                    )),
              ),
            ),
            _Albums(musicStatusx),
            GestureDetector(
              child: Container(
                height: 270,
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: PlayContainer(context, musicStatusx),
              ),
            ),
            const SizedBox(height: 24), // 底部留白
          ],
        ),
      ],
    ));
  }

  Container _Albums(MusicStatusX musicStatusx) {
    // final musicStatus = Provider.of<MusicStatus>(context);
    final getMusicInfo = musicStatusx.getMusicInfo;

    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'PlayName',
                  child: Text(
                    '${getMusicInfo['musicName']}',
                    style: const TextStyle(
                        color: tFontColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                Text('${getMusicInfo['user']}',
                    style: const TextStyle(
                        color: tFontColorGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 16)),
              ],
            ),
          ),
          Container(
            height: 30,
            width: 30,
            child: const Icon(
              FontAwesomeIcons.circle,
              color: Color.fromARGB(255, 155, 155, 155),
              size: 26,
            ),
          )
        ],
      ),
    );
  }

  Column PlayContainer(BuildContext context, MusicStatusX musicStatusx) {
    double playWidth = MediaQuery.of(context).size.width;
    // final musicStatus = Provider.of<MusicStatus>(context);
    final leftScale = Rx<double>(1.0);
    final rightScale = Rx<double>(1.0);

    return Column(
      children: [
        Container(
          height: 7,
          width: playWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(255, 157, 157, 157)),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '1:33',
              style: TextStyle(fontSize: 12, color: tFontColorGrey),
            ),
            Text(
              '-2:04',
              style: TextStyle(fontSize: 12, color: tFontColorGrey),
            )
          ],
        ),
        Container(
          padding:
              const EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: IconWithTapAnimation(
                    icon: const Icon(
                      FontAwesomeIcons.backward,
                      size: 32,
                      color: Color.fromARGB(255, 232, 232, 232),
                    ),
                    onTap: () {
                      musicStatusx.playPrevious();
                    },
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      musicStatusx.getStatus == false
                          ? await musicStatusx.play()
                          : await musicStatusx.pause();
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
                            // Hero(
                            //   tag: 'play',
                            //   child:
                            Icon(
                          key: ValueKey<RxBool>(musicStatusx.getStatus),
                          musicStatusx.getStatus == true
                              ? FontAwesomeIcons.pause
                              : FontAwesomeIcons.play,
                          size: 34,
                          color: const Color.fromARGB(255, 232, 232, 232),
                        )
                        // );
                        )),
                GestureDetector(
                  child:
                      // const Hero(
                      //   tag: 'next',
                      //   child:
                      IconWithTapAnimation(
                    icon: const Icon(
                      FontAwesomeIcons.forward,
                      size: 32,
                      color: Color.fromARGB(255, 232, 232, 232),
                    ),
                    onTap: () {
                      musicStatusx.playNext();
                    },
                    // ),
                  ),
                ),
              ]),
        ),
        Container(
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.volumeDown,
                size: 20,
                color: Color.fromARGB(255, 157, 157, 157),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Container(
                height: 6,
                width: playWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 157, 157, 157)),
              )),
              const SizedBox(width: 10),
              const Icon(
                FontAwesomeIcons.volumeUp,
                size: 16,
                color: Color.fromARGB(255, 157, 157, 157),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                FontAwesomeIcons.fire,
                color: Color.fromARGB(255, 157, 157, 157),
              ),
              Icon(
                FontAwesomeIcons.fire,
                color: Color.fromARGB(255, 157, 157, 157),
              ),
              Icon(
                FontAwesomeIcons.fire,
                color: Color.fromARGB(255, 157, 157, 157),
              ),
            ],
          ),
        )
      ],
    );
  }
}
