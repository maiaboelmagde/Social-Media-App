import 'package:social_media_app/features/posts/domain/repository/posts_repo_base.dart';

class AddPostUseCase {
  PostsRepoBase postsRepo;
  AddPostUseCase({required this.postsRepo});

  Future<void> call(content) async{
    await postsRepo.addPost(content);
  }
}
