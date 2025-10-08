import 'package:social_media_app/features/posts/data/data_source/posts_data_source.dart';
import 'package:social_media_app/features/posts/domain/entities/post_entity.dart';
import 'package:social_media_app/features/posts/domain/repository/posts_repo_base.dart';

class PostsRepoImpl extends PostsRepoBase {
  PostsDataSource postsDataSource;
  PostsRepoImpl({required this.postsDataSource});

  @override
  Future<void> addPost(String content) async {
    await postsDataSource.addPost(content);
  }

  @override
  Stream<List<PostEntity>> getPostsStream() {
    return postsDataSource.getPostsStream();
  }
}
