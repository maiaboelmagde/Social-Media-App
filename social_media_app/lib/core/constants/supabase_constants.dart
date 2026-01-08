class SupabaseConstants {
  static final String userImagesBucket = 'user-images';
  static String getUserImagePath(String userId) => 'users/$userId/profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
}
