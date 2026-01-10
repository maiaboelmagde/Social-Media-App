import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_media_app/core/constants/firestore_constants.dart';
import 'package:social_media_app/features/profile/data/data_source/personal_info_remote_data_source.dart';

class FirestorePersonalInfoRemoteDataSource
    extends PersonalInfoRemoteDataSource {
  FirestorePersonalInfoRemoteDataSource({required this.firestore});
  final FirebaseFirestore firestore;
  @override
  Future<void> updatePersonalInfo({
    required String userId,
    required String name,
    required String bio,
  }) async {
    try {
      await firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(userId)
          .update({
            FirestoreConstants.userFields.name: name,
            FirestoreConstants.userFields.bio: bio,
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

        batch.update(postRef, {FirestoreConstants.postFields.userName: name});
      }
      // Commit batch update
      await batch.commit();
    } on FirebaseException catch (e) {
      log(  'Error from FirestorePersonalInfoRemoteDataSource-updatePersonalInfo : ${e.message}');
      throw Exception('Failed to update personal info: Server error occurred. please try later.');
    } catch (e) {
      log(' Error from FirestorePersonalInfoRemoteDataSource-updatePersonalInfo : $e');
      throw Exception('An unexpected error occurred while updating personal info.');
    }
  }
}
