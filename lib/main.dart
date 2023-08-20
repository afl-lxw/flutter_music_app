import 'package:flutter/material.dart';
import 'package:flutter_music_app/data/color.dart';
import 'package:flutter_music_app/getx/music/musicStatus.dart';
import 'package:flutter_music_app/provider/musicStatus.dart';
import 'package:flutter_music_app/provider/tab_index.dart';
import 'package:flutter_music_app/router/router.dart' as MyAppRouter;
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterModel()),
        // ChangeNotifierProvider(create: (context) => MusicStatus()),
        FutureProvider<MusicStatus>(
          create: (BuildContext context) async {
            final musicStatus = MusicStatus(); // Initialize MusicStatus
            await musicStatus.getPlay.setAsset('assets/music/悬溺.mp3');
            return musicStatus;
          },
          initialData: MusicStatus(),
        ),
      ],
      child: GetMaterialApp(
        initialBinding: MusicStatusXBinding(), // 绑定控制器
        title: 'Music',
        theme: ThemeData(
            primarySwatch: customPrimaryColor,
            backgroundColor: tbgColor,
            useMaterial3: true,
            bottomAppBarColor: Colors.black),
        home: const MyAppRouter.Routing(),
      ),
    );
    // ChangeNotifierProvider(
    //     create: (context) => CounterModel(), // 创建数据模型实例
    //     lazy: true,
    //     child: MaterialApp(
    //       title: 'Music',
    //       theme: ThemeData(
    //           primarySwatch: customPrimaryColor,
    //           backgroundColor: tbgColor,
    //           useMaterial3: true,
    //           bottomAppBarColor: Colors.black),
    //       home: const Routing(),
    //     ));
  }
}
