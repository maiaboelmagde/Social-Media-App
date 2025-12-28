import 'package:social_media_app/features/posts/domain/repository/posts_repo_base.dart';

class DeletePostUseCase {
  PostsRepoBase postRepo;
  DeletePostUseCase({required this.postRepo});

  Future<void> call(String postId){
    return postRepo.deletePost(postId);
  }
}
