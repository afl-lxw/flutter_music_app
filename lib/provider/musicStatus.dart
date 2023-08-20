import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class MusicStatus extends ChangeNotifier {
  String _musicStatus = 'off'; // on   off
  late AudioPlayer _player; // Declare the _player variable

  MusicStatus() {
    _player = AudioPlayer(); // Initialize the player in the constructor
  }

  String get getStatus => _musicStatus;
  AudioPlayer get getPlay => _player;

  Future<void> play() async {
    await getPlay.play();
    await setNewStatus('on');
  }

  Future<void> pause() async {
    await getPlay.pause();
    await setNewStatus('off');
  }

  Future<void> setNewStatus(i) async {
    _musicStatus = i;
    notifyListeners();
  }

  void setPlayStatus(i) {
    _player = i;
    notifyListeners();
  }
}
