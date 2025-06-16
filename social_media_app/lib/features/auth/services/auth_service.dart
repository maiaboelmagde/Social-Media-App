import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/core/services/toast_service.dart';

class AuthService {
  AuthService._privateConstructor();
  static final _instance = AuthService._privateConstructor();
  factory AuthService() {
    return _instance;
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      ToastService.showToast('Sucessful Registration');
    } catch (e) {
      ToastService.showToast('Registration Failed: ${e.toString()}');
    }
  }
}
