class PostEntity {
  final String content;
  final String userId;
  final String userName;
  final DateTime? timestamp;

  PostEntity({
    required this.content,
    required this.userId,
    required this.userName,
    required this.timestamp
  });
}
