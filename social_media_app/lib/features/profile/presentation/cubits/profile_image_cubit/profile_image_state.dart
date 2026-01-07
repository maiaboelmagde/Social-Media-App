import 'dart:developer';

abstract class ProfileImageState {}

class ProfileImageInitial extends ProfileImageState {}

class ProfileImageLoading extends ProfileImageState {}

class ProfileImageSuccess extends ProfileImageState {
  final String imageUrl;
  ProfileImageSuccess(this.imageUrl) {
    log('From "ProfileImageCubit" Profile image updated successfully with URL: ${this.imageUrl}');
  }
}

class ProfileImageFailure extends ProfileImageState {
  final String errorMessage;
  ProfileImageFailure(this.errorMessage);
}
