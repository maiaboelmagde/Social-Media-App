import 'package:social_media_app/features/posts/domain/entities/post_entity.dart';
import 'package:social_media_app/features/posts/domain/repository/posts_repo_base.dart';

class GetPostsStreamUseCase {
  PostsRepoBase postsRepo;
  GetPostsStreamUseCase({required this.postsRepo});

  Stream<List<PostEntity>> call(){
    return postsRepo.getPostsStream();
  }
}
