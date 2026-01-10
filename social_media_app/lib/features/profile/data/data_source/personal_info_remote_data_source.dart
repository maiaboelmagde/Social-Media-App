abstract class PersonalInfoRemoteDataSource {
  Future<void> updatePersonalInfo({
    required String userId,
    required String name,
    required String bio,
  });
}
