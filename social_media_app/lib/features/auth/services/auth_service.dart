import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/core/services/toast_service.dart';

class AuthService {
  AuthService._privateConstructor();
  static final _instance = AuthService._privateConstructor();
  factory AuthService() => _instance;
  

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

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

        ToastService.showToast('Successful Registration');
        return true;
      }

      ToastService.showToast('Registration Failed: user is null');

      return false;
    } catch (e) {
      ToastService.showToast('Registration Failed: ${e.toString()}');
      log('From AuthService.registerUser :Registration Failed: ${e.toString()}');
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      ToastService.showToast('Please verify your email first.');
      return false;
    }
      ToastService.showToast('Successful Login');
      return true;
    } catch (e) {
      ToastService.showToast('Login Failed: ${e.toString()}');
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      await _auth.signOut();
      ToastService.showToast('Successful Logout');
      return true;
    } catch (e) {
      ToastService.showToast('Logout failed ${e.toString()}');
      return false;
    }
  }
}
