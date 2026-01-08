class UserFields {
  const UserFields();

  final String uid = 'uid';
  final String name = 'name';
  final String password = 'password';
  final String email = 'email';
  final String bio = 'bio';
  final String createdAt = 'createdAt';
  final String profileImageUrl = 'profileImageUrl';
  final String postsIds = 'postsIds';
}

class PostFields {
  const PostFields();

  final String content = 'content';
  final String userId = 'userId';
  final String userName = 'userName';
  final String userProfileImageUrl = 'userProfileImageUrl';
  final String timestamp = 'timestamp';
}

class FirestoreConstants {
  static final usersCollection = 'users';
  static final postsCollection = 'posts';

  static const UserFields userFields = UserFields();
  static const PostFields postFields = PostFields();
}
