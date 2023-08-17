import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_music_app/provider/tab_index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterIndexModel = Provider.of<CounterModel>(context);
    Color currentPrimaryColor = Theme.of(context).primaryColor;
    return Container(
      child: _selfNavBar(counterIndexModel, currentPrimaryColor),
    );
  }

  BottomNavigationBar _selfNavBar(
      CounterModel counterIndexModel, Color currentPrimaryColor) {
    return BottomNavigationBar(
      currentIndex: counterIndexModel.getIndex,
      onTap: ((value) => {
            counterIndexModel.setCurrentIndex(value),
          }),
      backgroundColor: Colors.transparent,
      selectedItemColor: currentPrimaryColor,
      iconSize: 22,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey[800],
      enableFeedback: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.headphones),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.poll),
          label: 'Trending',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.compactDisc),
          label: 'Radio',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.cog),
          label: 'Settings',
        ),
      ],
    );
  }
}
