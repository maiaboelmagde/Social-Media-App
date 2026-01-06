import 'dart:io';

abstract class ProfileRepositoryBase {
  Future<String> getProfileImageUrl({
    required String userId,
  });

  Future<void> updateProfileImage({
    required String userId,
    required File image,
  });
}
