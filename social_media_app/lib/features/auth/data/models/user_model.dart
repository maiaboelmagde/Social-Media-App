import 'package:social_media_app/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity{
  
  UserModel({required super.name, required super.email, required super.password});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) => UserModel(
    name: jsonData['name'],
    email: jsonData['email'],
    password: jsonData['password'],
  );
}
