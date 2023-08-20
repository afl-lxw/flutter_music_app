import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MusicStatusXBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MusicStatusX>(() => MusicStatusX());
    Get.find<MusicStatusX>().initPlayer(); // 初始化播放器
  }
}

class MusicStatusX extends GetxController {
  RxString _musicStatus = RxString('off'); // 使用RxString来管理状态  off
  late AudioPlayer _player; // Declare the _player variable

  void initPlayer() async {
    _player = AudioPlayer(); // Initialize the player in the constructor
    await _player.setAsset('assets/music/悬溺.mp3'); // 默认加载音乐
    //  _player.playerStateStream.listen((playerState) {
    //   if (playerState == AudioPlayerState.playing) {
    //     setNewStatus(RxString('on'));
    //   } else {
    //     setNewStatus(RxString('off'));
    //   }
    // });
    update(); // 通知UI刷新
  }

  RxString get getStatus => _musicStatus;
  AudioPlayer get getPlay => _player;

  Future<void> play() async {
    print('play 前 ${_musicStatus}');
    getPlay.play();
    print('play 后 ${_musicStatus}');
    setNewStatus(RxString('on'));
  }

  Future<void> pause() async {
    print('pause 前 ${_musicStatus}');

    getPlay.pause();
    print('pause 后 ${_musicStatus}');
    setNewStatus(RxString('off'));
  }

  void setNewStatus(RxString i) {
    print('setNewStatus 前 ${_musicStatus}');
    _musicStatus = i;
    print('setNewStatus 后 ${_musicStatus}');

    update(); // 使用update()来通知GetX进行UI刷新
  }
}
