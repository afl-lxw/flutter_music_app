import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class MusicStatus extends ChangeNotifier {
  String _musicStatus = 'on'; // on   off

  AudioPlayer _player = new AudioPlayer();

  String get getStatus => _musicStatus;
  AudioPlayer get getPlay => _player;

  void setNewStatus(i) {
    _musicStatus = i;
    notifyListeners();
  }

  void setPlayStatus(i) {
    _player = i;
    notifyListeners();
  }
}
