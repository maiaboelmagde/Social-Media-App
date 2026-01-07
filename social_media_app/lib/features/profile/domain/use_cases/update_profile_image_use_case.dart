import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class UpdateProfileImageUseCase {
  final ProfileRepositoryBase repository;

  UpdateProfileImageUseCase({required this.repository});

  Future<String> call({
    required String userId,
    required XFile imageFile,
  }) async{
    //log( 'From "UpdateProfileImageUseCase" Updating profile image for userId: $userId');
    String path = await repository.updateProfileImage(
      userId: userId,
      image: File(imageFile.path),
    );
    //log('From "UpdateProfileImageUseCase" Profile image updated at path: $path');
    return path;
  }
}
