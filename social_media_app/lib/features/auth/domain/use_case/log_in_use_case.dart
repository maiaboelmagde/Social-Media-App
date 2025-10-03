import 'package:social_media_app/features/auth/domain/repository/auth_repo_base.dart';

class LogInUseCase {
  LogInUseCase({required this.authRepo});
  AuthRepoBase authRepo;

  Future<bool> call({
    required String email,
    required String password
  }){
    return authRepo.loginUser(email: email, password: password);
  }
}