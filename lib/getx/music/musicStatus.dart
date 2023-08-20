import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_music_app/data/musicData.dart';
// import 'package:just_audio/src/shuffle_order.dart';

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
  late List<Map<String, dynamic>> musicData;
  late ConcatenatingAudioSource playlist;
  var currentIndex = 0.obs; // Using Getx to manage the current index
  var isShuffle = false.obs; // Using Getx to manage shuffle mode
  var loopMode = LoopMode.off.obs; // Using Getx to manage loop mode

  void initPlayer() async {
    _player = AudioPlayer(); // Initialize the _player in the constructor
    updatePlayList(musicDataList);

    _player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        playNext();
      }
    });

    update(); // 通知UI刷新
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  RxString get getStatus => _musicStatus;
  AudioPlayer get getPlay => _player;
  Map get getMusicInfo => musicData[currentIndex as int];

  // 更新当前播放列表
  Future<void> updatePlayList(list) async {
    musicData = [...list];
    List<AudioSource> audioSources = musicData.map((data) {
      return AudioSource.asset(data['musicPath']);
    }).toList();
    audioSources.shuffle();
    playlist = ConcatenatingAudioSource(
      // Start loading next item just before reaching it
      useLazyPreparation: true,
      // Customise the shuffle algorithm
      // shuffleOrder: DefaultShuffleOrder(),
      children: audioSources,
    );
    _player.setAudioSource(playlist);
  }

  //  播放
  Future<void> play() async {
    getPlay.play();
    setNewStatus(RxString('on'));
  }

  //  暂停
  Future<void> pause() async {
    getPlay.pause();
    setNewStatus(RxString('off'));
  }

  //  更新播放状态
  void setNewStatus(RxString i) {
    _musicStatus = i;
    update(); // 使用update()来通知GetX进行UI刷新
  }

  //  下一首
  Future<void> playNext() async {
    // await _player.seekToNext();
    if (currentIndex.value < musicData.length - 1) {
      currentIndex++;
    } else {
      currentIndex.value = 0;
    }
    await _player.seek(Duration.zero, index: currentIndex.value);
    await _player.play();
  }

  //  播放上一首
  Future<void> playPrevious() async {
    // await _player.seekToPrevious();
    if (currentIndex.value > 0) {
      currentIndex--;
    } else {
      currentIndex.value = musicData.length - 1;
    }
    await _player.seek(Duration.zero, index: currentIndex.value);
    await _player.play();
  }

  // 点击选择切换音乐
  Future<void> playCheckMusic(index) async {
    // await _player.seek(Duration.zero, index: 2);
    if (index >= 0 && index < musicData.length) {
      currentIndex.value = index;
      await _player.seek(Duration.zero, index: currentIndex.value);
      await _player.play();
    }
  }

  // 切换随机播放
  Future<void> toggleShuffle() async {
    isShuffle.toggle();
    if (isShuffle.value) {
      // await _player.setShuffleModeEnabled(true);
      _player.shuffle();
    } else {
      // await _player.setShuffleModeEnabled(false);
      // _player.clearShuffleOrder();
    }
  }

  // 切换循环播放
  void toggleLoop() {
    if (loopMode.value == LoopMode.off) {
      loopMode.value = LoopMode.one;
    } else if (loopMode.value == LoopMode.one) {
      loopMode.value = LoopMode.all;
    } else {
      loopMode.value = LoopMode.off;
    }
    _player.setLoopMode(loopMode.value);
  }

  // 更改播放速度
  void setPlaybackSpeed(double speed) {
    _player.setSpeed(speed);
  }
}
