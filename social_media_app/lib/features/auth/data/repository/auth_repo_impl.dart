import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/core/services/toast_service.dart';
import 'package:social_media_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:social_media_app/features/auth/domain/repository/auth_repo_base.dart';

class AuthRepoImpl extends AuthRepoBase {
  AuthRemoteDataSource remoteDataSource;

  AuthRepoImpl({required this.remoteDataSource});

  @override
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User? user = await remoteDataSource.registerUser(
        email: email,
        password: password,
        name: name,
      );
      if (user != null) {
        ToastService.showToast('Successful Registration');
        return true;
      }

      ToastService.showToast('Registration Failed: user is null');

      return false;
    } catch (e) {
      ToastService.showToast('Registration Failed: ${e.toString()}');
      log(
        'From AuthService.registerUser :Registration Failed: ${e.toString()}',
      );
      return false;
    }
  }

  @override
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      User? user = await remoteDataSource.loginUser(
        email: email,
        password: password,
      );
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

  @override
  Future<bool> logOut() async {
    try {
      await remoteDataSource.logOut();
      ToastService.showToast('Successful Logout');
      return true;
    } catch (e) {
      ToastService.showToast('Logout failed ${e.toString()}');
      return false;
    }
  }

  @override
  Future<bool> resetPassword({required String email}) async {
    try {
      await remoteDataSource.resetPassword(email: email);
      ToastService.showToast('Email sent Sucessfully ..');
      return true;
    } on Exception catch (_) {
      ToastService.showToast('Failed to send this email !! please try again');
      return false;
    }
  }
}
