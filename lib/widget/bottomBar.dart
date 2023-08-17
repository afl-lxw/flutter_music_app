import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_music_app/data/data.dart';
import '../provider/tab_index.dart'; // 之前创建的数据模型类

class ButtomBar extends StatefulWidget {
  const ButtomBar({super.key});

  @override
  State<ButtomBar> createState() => _ButtomBarState();
}

class _ButtomBarState extends State<ButtomBar> {
  @override
  Widget build(BuildContext context) {
    final counterIndexModel = Provider.of<CounterModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...List.generate(bottomBar.length, (i) {
          return GestureDetector(
            onTap: () => setState(() => {counterIndexModel.setCurrentIndex(i)}),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bottomBar[i],
                const SizedBox(height: 4),
                counterIndexModel.getIndex == i
                    ? Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      )
                    : Container()
              ],
            ),
          );
        })
      ],
    );
  }
}
