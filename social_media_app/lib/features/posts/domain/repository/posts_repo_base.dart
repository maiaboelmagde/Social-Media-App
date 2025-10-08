import 'package:social_media_app/features/posts/domain/entities/post_entity.dart';

abstract class PostsRepoBase {
  Future<void> addPost(String content);
  Stream<List<PostEntity>> getPostsStream();
}