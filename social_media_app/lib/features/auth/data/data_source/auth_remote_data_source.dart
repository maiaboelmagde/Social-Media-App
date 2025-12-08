import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': email,
        'name': name,
        'username': name,
        'bio': '',
        'createdAt': FieldValue.serverTimestamp(),
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
