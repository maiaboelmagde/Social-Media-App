import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/constants/firestore_constants.dart';
import 'package:social_media_app/features/profile/data/data_source/image_remote_data_source.dart';
import 'package:social_media_app/features/profile/data/data_source/personal_info_remote_data_source.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepositoryBase {
  final ImageRemoteDataSourceBase imageRemoteDataSource;
  final FirebaseFirestore firestore;
  final PersonalInfoRemoteDataSource personalInfoRemoteDataSource;

  ProfileRepositoryImpl({
    required this.imageRemoteDataSource,
    required this.firestore,
    required this.personalInfoRemoteDataSource,
  });

  @override
  Future<String?> getProfileImageUrl({required String userId}) async {
    final userSnapshot = await firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .get();
    return userSnapshot.data()?[FirestoreConstants.userFields.profileImageUrl];
  }

  @override
  Future<String> updateProfileImage({
    required String userId,
    required File image,
  }) async {
    //log(' From "ProfileRepositoryImpl" Updating profile image for userId: $userId , image path: ${image.path}');
    String uploadedImageUrl = await imageRemoteDataSource.uploadImage(
      userId: userId,
      imageFile: image,
    );
    //log(' From "ProfileRepositoryImpl" Profile image uploaded to URL: $uploadedImageUrl');
    await firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .update({
          FirestoreConstants.userFields.profileImageUrl: uploadedImageUrl,
        });

    final userSnapShot = await firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .get();

    final userPostsIds =
        userSnapShot.data()?[FirestoreConstants.userFields.postsIds] ?? [];

    // Batch update posts :
    final batch = firestore.batch();
    for (final postId in userPostsIds) {
      final postRef = firestore
          .collection(FirestoreConstants.postsCollection)
          .doc(postId);

      batch.update(postRef, {
        FirestoreConstants.postFields.userProfileImageUrl: uploadedImageUrl,
      });
    }
    // Commit batch
    await batch.commit();

    return uploadedImageUrl;
  }

  @override
  Future<void> updatePersonalInfo({
    required String userId,
    required String name,
    required String bio,
  }) async {
    return personalInfoRemoteDataSource.updatePersonalInfo(
      userId: userId,
      name: name,
      bio: bio,
    );
  }
}
