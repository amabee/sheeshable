class LikeData {
  late int _postId;
  late int _likeCount;
  late String _username;

  int get postId => _postId;
  set postId(int value) => _postId = value;
  int get likeCount => _likeCount;
  set likeCount(int value) => _likeCount = value;
  String get username => _username;
  set username(String value) => _username = value;
}
