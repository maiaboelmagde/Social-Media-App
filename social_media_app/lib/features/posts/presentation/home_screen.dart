import 'package:flutter/material.dart';
import 'package:social_media_app/core/di/service_locator.dart';
import 'package:social_media_app/core/extensions/media_query_values.dart';
import 'package:social_media_app/core/services/toast_service.dart';
import 'package:social_media_app/core/theme/theme_controller.dart';
import 'package:social_media_app/features/posts/domain/entities/post_entity.dart';
import 'package:social_media_app/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:social_media_app/features/posts/domain/use_cases/get_posts_stream_use_case.dart';
import 'package:social_media_app/features/profile/presentation/profile_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatelessWidget {
  final TextEditingController _postController = TextEditingController();

  HomeScreen({super.key});

  Future<void> _submitPost() async {
    final content = _postController.text.trim();
    if (content.isEmpty) return;

    try {
      await sl<AddPostUseCase>().call(content);
    } catch (e) {
      ToastService.showToast(e.toString());
    }
    _postController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Spacer(),
            Text('Home'),
            Spacer(),
            IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () => ThemeController.toggleTheme(),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Post input section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _postController,
                      decoration: const InputDecoration(
                        hintText: "What's on your mind?",
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _submitPost,
                        child: const Text('Post'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Posts list
          Expanded(
            child: StreamBuilder<List<PostEntity>>(
              stream: sl<GetPostsStreamUseCase>().call(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final posts = snapshot.data ?? [];

                if (posts.isEmpty) {
                  return const Center(child: Text("No posts yet."));
                }

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Image.asset('assets/images/user.png'),
                            ),
                            title: Text(post.userName),
                            //subtitle: Text(post.content),
                            subtitle: (post.timestamp != null)
                                ? Text(
                                    timeago.format(post.timestamp!),
                                    style: TextStyle(fontSize: 12),
                                  )
                                : Text(''),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: context.wp(0.1),
                              right: context.wp(0.1),
                              bottom: context.wp(0.05),
                            ),
                            child: Text(
                              post.content,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
