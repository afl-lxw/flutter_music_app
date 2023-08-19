import 'package:flutter/foundation.dart';

class MusicStatus extends ChangeNotifier {
  String _musicStatus = 'on'; // on   off

  String get getStatus => _musicStatus;

  void setNewStatus(i) {
    _musicStatus = i;
    notifyListeners();
  }
}
