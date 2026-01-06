import 'dart:io';

import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class UpdateProfileImageUseCase {
  final ProfileRepositoryBase repository;

  UpdateProfileImageUseCase(this.repository);

  Future<void> call({
    required String userId,
    required File imageFile,
  }) {
    return repository.updateProfileImage(
      userId: userId,
      image: imageFile,
    );
  }
}
