import 'package:social_media_app/features/posts/domain/repository/posts_repo_base.dart';

class UpdatePostUseCase {
  PostsRepoBase postRepo;
  UpdatePostUseCase({required this.postRepo});

  Future<void> call(String postId, String newContent){
    return postRepo.updatePost(postId, newContent);
  }
}
