import 'package:social_media_app/features/auth/domain/repository/auth_repo_base.dart';

class RegisterUseCase {
  RegisterUseCase({required this.authRepo});
  AuthRepoBase authRepo;

  Future<bool> call({
    required String name,
    required String email,
    required String password
  }){
    return authRepo.registerUser(name: name, email: email, password: password);
  }
}