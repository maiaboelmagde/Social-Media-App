import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/constants/firestore_constants.dart';
import 'package:social_media_app/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.postId,
    required super.content,
    required super.userId,
    required super.userName,
    required super.timestamp,
  });

  factory PostModel.fromJson(jsonData,String postId) => PostModel(
    postId: postId,
    content: jsonData[FirestoreConstants.postFields.content] ?? '',
    userId: jsonData[FirestoreConstants.postFields.userId] ?? '',
    userName: jsonData[FirestoreConstants.postFields.userName] ?? 'unknown',
    timestamp: (jsonData[FirestoreConstants.postFields.timestamp] as Timestamp?)?.toDate(),
  );
}
