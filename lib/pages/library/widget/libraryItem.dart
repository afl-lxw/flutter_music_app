import 'package:flutter/material.dart';
import 'package:flutter_music_app/data/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_music_app/data/data.dart';

class LibraryItemList extends StatefulWidget {
  const LibraryItemList({super.key, required this.index});
  final int index;

  @override
  State<LibraryItemList> createState() => _LibraryItemListState();
}

class _LibraryItemListState extends State<LibraryItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.grey[100],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // 设置子内容的边框半径
              child: Image(
                image: AssetImage(library[widget.index]['imgPath']),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    library[widget.index]['name'],
                    style: const TextStyle(
                        fontSize: 15,
                        color: tFontColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    library[widget.index]['description'],
                    style: const TextStyle(
                        fontSize: 14,
                        color: tFontColorGrey,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
