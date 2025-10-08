import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/core/constants/firestore_constants.dart';
import 'package:social_media_app/features/posts/domain/entities/post_entity.dart';

class PostsDataSource {
  FirebaseAuth auth;
  FirebaseFirestore fireStore;

  PostsDataSource({required this.auth, required this.fireStore});

  Future<void> addPost(String content) async {
    User? user = auth.currentUser;
    if (user == null) throw Exception("User didn't login !!");
    try {
      final String userName = await fireStore
          .collection(FirestoreConstants.postsCollection)
          .doc(user.uid)
          .get()
          .then(
            (value) =>
                value[FirestoreConstants.userFields.username] ?? 'unKnown',
          );
      
      fireStore.collection(FirestoreConstants.postsCollection).add({
        FirestoreConstants.postFields.content : content,
        FirestoreConstants.postFields.userId: user.uid,
        FirestoreConstants.postFields.userName: userName,
        FirestoreConstants.postFields.timestamp: FieldValue.serverTimestamp()
      });

    } on FirebaseException catch (_) {
      throw Exception('Server Error while adding the post, please try later');
    } catch (e){
      throw Exception('Unexpected error occurred.');
    }
  }

  Stream<List<PostEntity>> getPostsStream() {
    // TODO: implement getPostsStream
    throw UnimplementedError();
  }
}
