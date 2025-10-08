class UserFields {
  const UserFields();

  final String uid = 'uid';
  final String name = 'name';
  final String username = 'username';
  final String email = 'email';
  final String bio = 'bio';
  final String createdAt = 'createdAt';
}

class PostFields {
  const PostFields();

  final String content = 'content';
  final String userId = 'userId';
  final String userName = 'userName';
  final String timestamp = 'timestamp';
}

class FirestoreConstants {
  static final usersCollection = 'users';
  static final postsCollection = 'posts';

  static const UserFields userFields = UserFields();
  static const PostFields postFields = PostFields();
}
