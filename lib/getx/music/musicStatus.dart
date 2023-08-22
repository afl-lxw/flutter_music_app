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

// 播放音频的状态
enum SDAudioPlayerState {
  idle, // 默认
  loading, // 加载中
  buffering, // 缓存中
  ready, // 可播放
  completed, // 播放完成
}

class MusicStatusX extends GetxController {
  RxBool getPlayStatus = false.obs; // 使用RxString来管理状态  off
  late AudioPlayer _player; // Declare the _player variable
  late List<Map<String, dynamic>> musicData;
  late ConcatenatingAudioSource playlist;
  var currentIndex = 0.obs; // Using Getx to manage the current index
  var isShuffle = false.obs; // Using Getx to manage shuffle mode
  var loopMode = LoopMode.off.obs; // Using Getx to manage loop mode
  var isRandomPlaying = false.obs; // Using Getx to manage random playing state

  Rx<Map<String, dynamic>> currentMusicInfo =
      Rx<Map<String, dynamic>>({}); // 当前歌曲信息
// -----------------------------------------------------------------
  void initPlayer() async {
    _player = AudioPlayer(); // Initialize the _player in the constructor
    await updatePlayList(musicDataList);

    update(); // 通知UI刷新
  }

  @override
  void onInit() {
    /// 每次`name`变化时调用。
    // ever(name, (callback)=> null);

    /// 每次监听多个值变化时调用。
    everAll([getPlayStatus, currentIndex], (callback) => null);

    /// 只有在变量第一次被改变时才会被调用
    // once(name, (callback) => null);

    /// 场景：变量频繁改变，如果用户多次输入、多次点击等。 防DDos - 当变量停止变化1秒后调用，
    /// 例如：搜索功能。用户输入完整单词后再执行搜索操作，而不是用户每输入一个字符就要进行一次操作
    // debounce(name, (callback) => null,time: const Duration(seconds: 1));

    /// 忽略指定时间内变量的所有变化
    // interval(name, (callback) => null,time: const Duration(seconds: 1));

    super.onInit();
  }

  /// 加载完成
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }
// -----------------------------------------------------------------

  // 当前自定义播放状态
  RxBool get getStatus => getPlayStatus;
  // 当前播放状态
  // PlayerState get getPlayStatus => getPlay.playerState;
  // 当前实例
  AudioPlayer get getPlay => _player;
  // 获取当前播放
  int? get getCurrentIndex => _player.currentIndex;
  // 获取单歌曲信息
  Map<String, dynamic> get getMusicInfo {
    final currentIndex = _player.currentIndex;
    if (currentIndex != null) {
      return musicData[currentIndex];
    }
    return {}; // Return a default value or handle the case where currentIndex is null
  }

  // 获取当前播放列表
  ConcatenatingAudioSource get getCurrentPlaylist => playlist;
  // 获取当前是否是随机播放模式
  bool get isShuffleMode => _player.shuffleModeEnabled;
  // 获取当前循环模式
  LoopMode get getCurrentLoopMode => _player.loopMode;
// -----------------------------------------------------------------

  // 更新当前歌曲信息
  void updateCurrentMusicInfo() {
    final currentIndex = _player.currentIndex;
    if (currentIndex != null) {
      currentMusicInfo.value = musicData[currentIndex];
    }
    update(); // 通知UI刷新
  }

  // 更新当前播放列表
  Future<void> updatePlayList(list) async {
    musicData = [...list];
    print(musicData);
    List<AudioSource> audioSources = musicData.map((data) {
      return AudioSource.asset(data['musicPath']);
    }).toList();
    audioSources.shuffle();
    playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: audioSources,
    );
    try {
      await _player.setAudioSource(playlist,
          initialIndex: currentIndex.value, initialPosition: Duration.zero);
    } catch (e) {
      print(e);
    }

    // 自动播放下一首
    _player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        final currentIndex = _player.currentIndex;

        if (currentIndex != null && currentIndex == musicData.length - 1) {
          playCheckMusic(0); // Play the first song when the last song completes
        } else {
          playNext();
        }
      }
    });
    update(); // 通知UI刷新
  }

  // 实时更新音乐状态
  void updateIsPlaying() {
    final playerState = _player.playerState;
    print(
      'playerState ------- ${_player.playerState}',
    );
    if (playerState.playing == true) {
      getPlayStatus.value = true;
    } else {
      getPlayStatus.value = false;
    }
    update();
  }

  //  播放
  Future<void> play() async {
    print(
      'play --- bonfore---- ${_player.playerState}',
    );
    _player.play();
    print(
      'play ---after --- ${_player.playerState}',
    );
    await Future.delayed(const Duration(milliseconds: 100));
    updateIsPlaying();
    updateCurrentMusicInfo();
    update(); // 使用update()来通知GetX进行UI刷新
  }

  //  暂停
  Future<void> pause() async {
    await _player.pause();
    await Future.delayed(const Duration(milliseconds: 100));
    updateIsPlaying();
    update(); // 使用update()来通知GetX进行UI刷新
  }

  //  下一首
  Future<void> playNext() async {
    await _player.seekToNext();
    if (_player.playerState.playing == false &&
        _player.playerState.processingState == ProcessingState.ready) {
      play();
    }
    update(); // 使用update()来通知GetX进行UI刷新
  }

  //  播放上一首
  Future<void> playPrevious() async {
    await _player.seekToPrevious();
    if (_player.playerState.playing == false &&
        _player.playerState.processingState == ProcessingState.ready) {
      play();
    }
    update();
  }

  // 点击选择切换音乐
  Future<void> playCheckMusic(index) async {
    // await _player.seek(Duration.zero, index: 2);
    if (index >= 0 && index < musicData.length) {
      currentIndex = index;
      await _player.seek(Duration.zero, index: currentIndex.value);
      await _player.play();
      updateCurrentMusicInfo();
    }
  }

  // 切换随机播放
  Future<void> toggleShuffle() async {
    isShuffle.toggle();
    if (isShuffle.value) {
      await _player.setShuffleModeEnabled(true);
    } else {
      await _player.setShuffleModeEnabled(false);
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
