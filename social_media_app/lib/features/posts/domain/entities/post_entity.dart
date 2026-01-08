class PostEntity {
  final String postId;
  final String content;
  final String userId;
  final String userName;
  final String? userProfileImageUrl;
  final DateTime? timestamp;


  PostEntity({
    required this.postId,
    required this.content,
    required this.userId,
    required this.userName,
    this.userProfileImageUrl,
    this.timestamp
  });
}
