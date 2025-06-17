import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/theme_controller.dart';
import 'package:social_media_app/features/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _postController = TextEditingController();

  HomeScreen({super.key});

  Future<void> _submitPost() async {
    final content = _postController.text.trim();
    if (content.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      log("User ID: ${user.uid}");
    } else {
      log("No user is currently signed in.");
      return;
    }

    final userDoc = await FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .get();
    

  final name = userDoc.data()?['name'] ?? 'Unknown';

    await FirebaseFirestore.instance.collection('posts').add({
      'content': content,
      'userId': user.uid,
      'userName': name,
      'timestamp': FieldValue.serverTimestamp(),
    });

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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No posts yet."));
                }

                final posts = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index].data() as Map<String, dynamic>;
                    return ListTile(
                      leading: CircleAvatar(
                        child: Image.asset('assets/images/user.png'),
                      ),
                      title: Text(post['userName'] ?? 'Unknown'),
                      subtitle: Text(post['content']),
                      trailing: Text(
                        (post['timestamp'] as Timestamp?)
                                ?.toDate()
                                .toLocal()
                                .toString()
                                .split('.')
                                .first ??
                            '',
                        style: TextStyle(fontSize: 12),
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
