import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/di/service_locator.dart';
import 'package:social_media_app/core/Enums/post_options_enum.dart';
import 'package:social_media_app/core/extensions/media_query_values.dart';
import 'package:social_media_app/features/posts/domain/entities/post_entity.dart';
import 'package:social_media_app/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:social_media_app/features/posts/domain/use_cases/update_post_use_case.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  PostWidget({super.key, required this.post});

  final PostEntity post;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  final _formKey = GlobalKey<FormState>();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    contentController.text = post.content;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(child: Image.asset('assets/images/user.png')),
            title: Text(post.userName),
            trailing: currentUserId == post.userId
                ? PopupMenuButton(
                    icon: Icon(Icons.more_horiz),
                    itemBuilder: (BuildContext context) => const [
                      PopupMenuItem(
                        value: PostOptionsEnum.edit,
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: PostOptionsEnum.delete,
                        child: Text('Delete'),
                      ),
                    ],
                    onSelected: (value) => switch (value) {
                      PostOptionsEnum.delete => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete post'),
                          content: Text(
                            'Are you sure you want to delete this post? \nThis action cannot be undone.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                sl<DeletePostUseCase>().call(post.postId);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      ),
                      PostOptionsEnum.edit => showModalBottomSheet(
                        context: context,
                        builder: (_) => GestureDetector(
                          onTap: () =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          child: FractionallySizedBox(
                            heightFactor: 0.75,
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                children: [
                                  TextFormField(
                                    controller: contentController,
                                    validator: (value) => value?.isEmpty ?? true
                                        ? "There's no content !!"
                                        : null,
                                    maxLines: 5,
                                  ),
                                  SizedBox(height: context.hp(0.2)),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final isValid =
                                          _formKey.currentState?.validate() ??
                                          false;
                                      if (!isValid) return;
                                      await sl<UpdatePostUseCase>().call(
                                        post.postId,
                                        contentController.text,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        enableDrag: true,
                        showDragHandle: true,
                        isScrollControlled: true,
                      ),
                    },
                  )
                : null,
            subtitle: (post.timestamp != null)
                ? Text(
                    timeago.format(post.timestamp!),
                    style: TextStyle(fontSize: 12),
                  )
                : null,
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
  }
}
