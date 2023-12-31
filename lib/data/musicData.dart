Map<String, String> musicText = {
  "00:01": "几百遍 重复了几百遍",
  "00:02": "重复的情绪重复了熬过想你的夜",
  "00:03": "这思念难道直到感受不到痛为止",
  "00:04": "可这过程我怎么可能会装作没事",
  "00:05": "你教会我怎么爱你却没教会遗忘",
  "00:06": "随意的举动撕碎我所有的立场",
  "00:07": "我心知肚明不愿戳穿你的另一面",
  "00:08": "却没想过如今变成我的nightmare",
  "00:09": "昏黄的路灯照不亮整条街",
  "00:10": "我怎么用力也走不到你心里",
  "00:20": "倾盆的雨下了一整夜",
  "00:30": "我们离得这么近你却看不清楚我的泪滴",
  "00:40": "我知道我可以随时被代替",
  "00:50": "却还是接受不了这种落差",
  "00:60": "我们的爱就像是流星落下",
  "01:00": "随烟火消失的火花",
};

List<Map<String, dynamic>> musicDataList = [
  {
    'musicName': '我好像在哪见过你',
    'user': '薛之谦',
    'musicPath': 'assets/music/我好像在哪见过你.mp3',
    'imgAvatar': 'assets/images/albums/6.png'
  },
  {
    'musicName': '那是你离开北京的生活',
    'user': '薛之谦',
    'musicPath': 'assets/music/那是你离开北京的生活.mp3',
    'imgAvatar': 'assets/images/albums/2.png'
  },
  {
    'musicName': '溯',
    'user': '马吟吟',
    'musicPath': 'assets/music/溯.mp3',
    'imgAvatar': 'assets/images/albums/3.png'
  },
  {
    'musicName': '悬溺',
    'user': '葛东琪',
    'musicPath': 'assets/music/悬溺.mp3',
    'imgAvatar': 'assets/images/albums/4.png'
  },
  {
    'musicName': 'fade',
    'user': 'Alan Walker',
    'musicPath': 'assets/music/fade.mp3',
    'imgAvatar': 'assets/images/albums/5.png'
  },
];

class MusicData {
  final String musicName;
  final String user;
  final String musicPath;

  MusicData({
    required this.musicName,
    required this.user,
    required this.musicPath,
  });
}
