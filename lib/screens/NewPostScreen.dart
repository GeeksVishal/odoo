import 'package:flutter/material.dart';
import 'HomeScreen.dart';
// for QuestionData

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  void _sendPost() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty || desc.isEmpty) return;

    final newPost = QuestionData(
      title: title,
      description: desc,
      tags: ['flutter'], // default tags
      likes: 0,
      answers: 0,
      timeAgo: 'Just now',
    );

    Navigator.pop(context, newPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Post"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Post Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Post Description'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _sendPost,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Send', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
