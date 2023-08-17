import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_music_app/pages/library/views/albums/albums.dart';
import 'package:flutter_music_app/pages/library/views/artists/artists.dart';
import 'package:flutter_music_app/pages/library/views/playLists/playLists.dart';
import 'package:flutter_music_app/pages/library/views/songs/songs.dart';

// ! Routing
int currentIndex = 0;
double tabRadisValue = 20;
// ! Routing

List bottomBar = [
  const Icon(
    FontAwesomeIcons.compass,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.store,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.heart,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.user,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.user,
    color: Colors.white,
  ),
];

final List<Map<String, dynamic>> libraryData = [
  {
    'icon': FontAwesomeIcons.music,
    'name': "PlayLists",
    'context': PlayListsWidget
  },
  {'icon': FontAwesomeIcons.bars, 'name': "Artists", 'context': ArtistsWidget},
  {'icon': FontAwesomeIcons.music, 'name': "Songs", 'context': SongsWidget},
  {'icon': FontAwesomeIcons.music, 'name': "Albums", 'context': AlbumsWidget},
];

List<Map<String, dynamic>> library = [
  {
    'imgPath': 'assets/images/albums/1.png',
    'name': "in hreat",
    'description': 'Lemo ',
  },
  {
    'imgPath': 'assets/images/albums/2.png',
    'name': "晚风",
    'description': 'copy2',
  },
  {
    'imgPath': 'assets/images/albums/3.png',
    'name': "失语者",
    'description': '蔡健雅',
  },
  {
    'imgPath': 'assets/images/albums/4.png',
    'name': "Best the one",
    'description': 'slkd se',
  },
  {
    'imgPath': 'assets/images/albums/5.png',
    'name': "shape H",
    'description': 'huang',
  },
  {
    'imgPath': 'assets/images/albums/6.png',
    'name': "sky",
    'description': 'sdl oi',
  },
];
