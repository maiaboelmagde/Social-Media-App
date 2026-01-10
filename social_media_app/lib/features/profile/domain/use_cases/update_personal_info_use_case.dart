import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class UpdatePersonalInfoUseCase {
  final ProfileRepositoryBase repository;

  UpdatePersonalInfoUseCase({required this.repository});

  Future<void> call({
    required String userId,
    required String name,
    required String bio,
  }) {
    return repository.updatePersonalInfo(
      userId: userId,
      name: name,
      bio: bio,
    );
  }
}
