import 'package:flutter/material.dart';
import 'package:flutter_music_app/data/color.dart';
import 'package:flutter_music_app/data/data.dart';
import 'package:flutter_music_app/data/images.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LibraryListWidget extends StatefulWidget {
  const LibraryListWidget({super.key, required this.index});
  final int index;

  @override
  State<LibraryListWidget> createState() => _LibraryListWidgetState();
}

class _LibraryListWidgetState extends State<LibraryListWidget> {
  @override
  Widget build(BuildContext context) {
    // 获取主题色
    Color currentPrimaryColor = Theme.of(context).primaryColor;

    return _ListWidget(widget.index, currentPrimaryColor);
  }

  Container _ListWidget(int index, Color currentPrimaryColor) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 15, 15, 15),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(
            libraryData[index]['icon'],
            color: currentPrimaryColor,
            size: 18,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            libraryData[index]['name'],
            style: TextStyle(color: tFontColor),
          ),
          const Spacer(),
          const Icon(
            FontAwesomeIcons.angleRight,
            color: tFontColorGrey,
          )
        ],
      ),
    );
  }
}
