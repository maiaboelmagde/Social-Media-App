import 'dart:io';

abstract class ProfileRepositoryBase {
  Future<String?> getProfileImageUrl({
    required String userId,
  });

  Future<String> updateProfileImage({
    required String userId,
    required File image,
  });

  Future<void> updatePersonalInfo({
    required String userId,
    required String name,
    required String bio,
  });
}
