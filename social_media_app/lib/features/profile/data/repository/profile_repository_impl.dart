import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/constants/firestore_constants.dart';
import 'package:social_media_app/features/profile/data/data_source/image_remote_data_source.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepositoryBase {
  final ImageRemoteDataSourceBase imageRemoteDataSource;
  final FirebaseFirestore firestore;

  ProfileRepositoryImpl({
    required this.imageRemoteDataSource,
    required this.firestore,
  });

  @override
  Future<String> getProfileImageUrl({required String userId}) async {
    // This method is not implemented yet
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfileImage({
    required String userId,
    required File image,
  }) async {
    String uploadedImageUrl = await imageRemoteDataSource.uploadImage(
      userId: userId,
      imageFile: image,
    );

    await firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .update({
          FirestoreConstants.userFields.profileImageUrl: uploadedImageUrl,
        });
  }
}
