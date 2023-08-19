import 'package:flutter/material.dart';
import 'package:flutter_music_app/pages/library/library.dart';
import 'package:flutter_music_app/pages/radio/radio.dart';
import 'package:flutter_music_app/pages/search/search.dart';
import 'package:flutter_music_app/pages/setting/setting.dart';
import 'package:flutter_music_app/pages/trending/trending.dart';
import 'package:flutter_music_app/provider/tab_index.dart';
// import 'package:flutter_music_app/widget/bottomBar.dart';
import 'package:flutter_music_app/widget/customBottomBar.dart';
import 'package:flutter_music_app/widget/myClipper.dart';
import 'package:flutter_music_app/widget/player.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class Routing extends StatefulWidget {
  const Routing({super.key});

  @override
  State<Routing> createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  List<Widget> routing = [
    const Library(),
    const Trending(),
    const Search(),
    const RadioWidget(),
    const Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    final counterIndexModel = Provider.of<CounterModel>(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // 获取 BottomNavigationBar 的高度
          double bottomNavBarHeight = kBottomNavigationBarHeight;

          return Stack(
            children: [
              routing[counterIndexModel.getIndex],

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRect(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35), // 模糊效果
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 65, 65, 65)
                          .withOpacity(0.3), // 颜色混合效果
                      BlendMode.srcATop,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4), // 背景颜色
                      ),
                    ),
                  ),
                )),
              ),

              // 底部栏
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomBottomBar(),
              ),

              Positioned(
                left: 10,
                right: 10,
                bottom: 95,
                child: ClipPath(
                    clipper:
                        MyClipper(borderRadius: BorderRadius.circular(10.0)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35), // 模糊效果
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          const Color.fromARGB(255, 65, 65, 65)
                              .withOpacity(0.4), // 颜色混合效果
                          BlendMode.srcATop,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4), // 背景颜色
                          ),
                          width: double.infinity,
                          height: 65,
                        ),
                      ),
                    )),
              ),

              Positioned(
                bottom: 92,
                left: 10, // 左侧偏移量
                right: 10, // 右侧偏移量
                child: Container(
                  height: 2, // 阴影高度
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ]),
                ),
              ),

              const Positioned(
                  left: 10, right: 10, bottom: 95, child: PlayerWidget()),
            ],
          );
        },
      ),
      // bottomNavigationBar: CustomBottomBar(),
    );
  }
}
