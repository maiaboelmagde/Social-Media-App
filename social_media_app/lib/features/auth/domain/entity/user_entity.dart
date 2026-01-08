class UserEntity {
  final String name;
  final String email;
  final String password;
  final String? bio;
  final DateTime? createdAt;
  final String? profileImageUrl; 

  UserEntity({required this.name, required this.email, required this.password, this.bio, this.createdAt, this.profileImageUrl});
}

