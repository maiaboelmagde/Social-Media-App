import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/core/constants/firestore_constants.dart';
import 'package:social_media_app/features/posts/data/models/post_model.dart';
import 'package:social_media_app/features/posts/domain/entities/post_entity.dart';

class PostsDataSource {
  FirebaseAuth auth;
  FirebaseFirestore fireStore;

  PostsDataSource({required this.auth, required this.fireStore});

  Future<void> addPost(String content) async {
    User? user = auth.currentUser;
    if (user == null) throw Exception("User didn't login !!");
    try {
      final [userName, userProfileImageUrl] = await fireStore
          .collection(FirestoreConstants.usersCollection)
          .doc(user.uid)
          .get()
          .then(
            (value) => [
              value[FirestoreConstants.userFields.name] ?? 'unKnown',
              value[FirestoreConstants.userFields.profileImageUrl],
            ],
          );

      final colRef = await fireStore
          .collection(FirestoreConstants.postsCollection)
          .add({
            FirestoreConstants.postFields.content: content,
            FirestoreConstants.postFields.userId: user.uid,
            FirestoreConstants.postFields.userName: userName,
            FirestoreConstants.postFields.userProfileImageUrl:
                userProfileImageUrl,
            FirestoreConstants.postFields.timestamp:
                FieldValue.serverTimestamp(),
          });

      // handle array of postsId for each user
      FirebaseFirestore.instance
          .collection(FirestoreConstants.usersCollection)
          .doc(user.uid)
          .update({
            FirestoreConstants.userFields.postsIds: FieldValue.arrayUnion([
              colRef.id,
            ]),
          });
    } on FirebaseException catch (_) {
      //log('Error from PostsDataSource-addPost : ${e.message}');
      throw Exception('Server Error while adding the post, please try later');
    } catch (e) {
      throw Exception('Unexpected error occurred.');
    }
  }

  Stream<List<PostEntity>> getPostsStream() {
    return fireStore
        .collection(FirestoreConstants.postsCollection)
        .orderBy(FirestoreConstants.postFields.timestamp, descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => PostModel.fromJson(doc.data(), doc.id))
              .toList();
        });
  }

  Future<void> deletePost(String postId,String userId) async {
    try {
      await fireStore
          .collection(FirestoreConstants.postsCollection)
          .doc(postId)
          .delete();

        FirebaseFirestore.instance
          .collection(FirestoreConstants.usersCollection)
          .doc(userId)
          .update({
            FirestoreConstants.userFields.postsIds: FieldValue.arrayRemove([
              postId,
            ]),
          });
    } on FirebaseException catch (_) {
      //log('Error from PostsDataSource-deletePost : ${e.message}');
      throw Exception('Server Error while deleting the post, please try later');
    } catch (e) {
      throw Exception('Unexpected error occurred.');
    }
  }

  Future<void> updatePost(String postId, String newContent) async {
    try {
      await fireStore
          .collection(FirestoreConstants.postsCollection)
          .doc(postId)
          .update({FirestoreConstants.postFields.content: newContent});
    } on FirebaseException catch (_) {
      //log('Error from PostsDataSource-updatePost : ${e.message}');
      throw Exception('Server Error while updating the post, please try later');
    } catch (e) {
      throw Exception('Unexpected error occurred.');
    }
  }
}
