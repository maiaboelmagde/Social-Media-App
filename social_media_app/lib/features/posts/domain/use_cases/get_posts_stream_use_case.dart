import 'package:social_media_app/features/posts/domain/repository/posts_repo_base.dart';

class GetPostsStreamUseCase {
  PostsRepoBase postsRepo;
  GetPostsStreamUseCase({required this.postsRepo});

  Future<void> call() async{
    postsRepo.getPostsStream();
  }
}
