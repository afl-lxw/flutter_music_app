import 'package:flutter/material.dart';
import 'package:flutter_music_app/data/color.dart';
import 'package:flutter_music_app/provider/musicStatus.dart';
import 'package:flutter_music_app/provider/tab_index.dart';
import 'package:flutter_music_app/router/router.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (context) => MusicStatus()),
      ],
      child: MaterialApp(
        title: 'Music',
        theme: ThemeData(
            primarySwatch: customPrimaryColor,
            backgroundColor: tbgColor,
            useMaterial3: true,
            bottomAppBarColor: Colors.black),
        home: const Routing(),
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
