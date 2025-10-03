abstract class AuthRepoBase {
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<bool> loginUser({
    required String email,
    required String password,
  });

  Future<bool> logOut();
}
