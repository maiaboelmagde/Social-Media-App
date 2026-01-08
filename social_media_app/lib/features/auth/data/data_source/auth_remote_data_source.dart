import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/core/constants/firestore_constants.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    if (user != null) {
      await user.sendEmailVerification();

      await _firestore.collection(FirestoreConstants.usersCollection).doc(user.uid).set({
        FirestoreConstants.userFields.uid: user.uid,
        FirestoreConstants.userFields.email: email,
        FirestoreConstants.userFields.name: name,
        FirestoreConstants.userFields.bio: '',
        FirestoreConstants.userFields.createdAt: FieldValue.serverTimestamp(),
      });
    }

    return user;
  }


  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> logOut()async{
    await _auth.signOut();
  }

  resetPassword({required String email})async{
    await _auth.sendPasswordResetEmail(email: email);
  }
}
