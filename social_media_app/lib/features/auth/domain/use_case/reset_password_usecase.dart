import 'package:social_media_app/features/auth/domain/repository/auth_repo_base.dart';

class ResetPasswordUsecase {
  ResetPasswordUsecase({required this.authRepo});
  AuthRepoBase authRepo;

  Future<void> call({
    required String email
  }){
    return authRepo.resetPassword(email: email);
  }
}