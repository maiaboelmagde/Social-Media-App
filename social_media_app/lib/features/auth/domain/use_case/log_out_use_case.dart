import 'package:social_media_app/features/auth/domain/repository/auth_repo_base.dart';

class LogOutUseCase {
  AuthRepoBase authRepo;
  LogOutUseCase({required this.authRepo});

  Future<void>call(){
    return authRepo.logOut();
  }
}
