import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/constants/firestore_constants.dart';
import 'package:social_media_app/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity{
  
  UserModel({required super.name, required super.email, required super.password, super.createdAt, super.bio, super.profileImageUrl});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) => UserModel(
    name: jsonData[FirestoreConstants.userFields.name],
    email: jsonData[FirestoreConstants.userFields.email],
    password: jsonData[FirestoreConstants.userFields.password],
    createdAt: (jsonData[FirestoreConstants.userFields.createdAt] as Timestamp?)?.toDate(),
  );

  Map<String, dynamic> toJson() => {
    FirestoreConstants.userFields.name: name,
    FirestoreConstants.userFields.email: email,
    FirestoreConstants.userFields.password: password,
    FirestoreConstants.userFields.bio: bio,
    FirestoreConstants.userFields.createdAt: createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    FirestoreConstants.userFields.profileImageUrl: profileImageUrl,
  };
}
