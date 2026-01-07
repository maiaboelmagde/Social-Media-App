import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/features/profile/domain/use_cases/update_profile_image_use_case.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_image_cubit/profile_image_state.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  final UpdateProfileImageUseCase updateProfileImageUseCase;

  ProfileImageCubit(this.updateProfileImageUseCase)
    : super(ProfileImageInitial());

  Future<void> updateProfileImage({
    required String userId,
    required XFile imageFile,
  }) async {
    emit(ProfileImageLoading());
    try {
      String imageUrl = await updateProfileImageUseCase.call(
        userId: userId,
        imageFile: imageFile,
      );
      //log('From "ProfileImageCubit" Profile image updated successfully');
      emit(ProfileImageSuccess(imageUrl));
    } catch (e) {
      log(' From "ProfileImageCubit" Error updating profile image: $e');
      emit(ProfileImageFailure(e.toString()));
    }
  }
}
