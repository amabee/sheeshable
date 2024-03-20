class LikeData {
  final int postId;
  final String likeCount;

  LikeData({required this.postId, required this.likeCount});

  factory LikeData.fromJson(Map<String, dynamic> json) {
    return LikeData(
      postId: json['post_id'],
      likeCount: json['user_like_count'],
    );
  }
}
