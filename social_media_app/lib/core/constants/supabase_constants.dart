class SupabaseConstants {
  static final String userImagesBucket = 'user-images';
  static String getUserImagePath(String userId) => 'users/$userId/profile.jpg';
}
