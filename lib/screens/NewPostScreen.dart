import 'package:flutter/material.dart';
import '../helper/db_helper.dart'; // ✅ Ensure correct path

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool _saving = false;

  Future<void> _sendPost() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _saving = true);

    final newPost = {
      'title': title,
      'description': desc,
      'tags': '["flutter"]',  // Store tags as JSON string
      'likes': 0,
      'answers': 0,
      'timeAgo': 'Just now',
    };

    try {
      await DBHelper.insertQuestion(newPost);
      if (mounted) Navigator.pop(context, true); // ✅ Return true to refresh home
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Post",style: TextStyle(color: Colors.blue),),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            SafeArea(
              child: ElevatedButton(
                onPressed: _saving ? null : _sendPost,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: _saving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Add', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
