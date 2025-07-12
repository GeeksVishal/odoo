import 'package:flutter/material.dart';

void main() => runApp(StackItApp());

class StackItApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StackIt',
    );
  }
}

class StackItHomePage extends StatelessWidget {
  final List<QuestionItem> questions = [
    QuestionItem(
      title: 'How to use Provider in Flutter?',
      subtitle:
      'I’m new to state management. How does Provider work and when should I use it?',
      tags: ['flutter', 'provider', 'state-management'],
      likes: 12,
      answers: 3,
      timeAgo: '2h ago',
    ),
    QuestionItem(
      title: 'Firebase vs Supabase for Flutter app?',
      subtitle:
      'Which backend is better for authentication and database?',
      tags: ['flutter', 'firebase', 'supabase'],
      likes: 8,
      answers: 5,
      timeAgo: '5h ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F3DFF),
        elevation: 0,
        title: const Text(
          'StackIt',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return QuestionCard(question: questions[index]);
        },
      ),
    );
  }
}

class QuestionItem {
  final String title;
  final String subtitle;
  final List<String> tags;
  final int likes;
  final int answers;
  final String timeAgo;

  QuestionItem({
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.likes,
    required this.answers,
    required this.timeAgo,
  });
}

class QuestionCard extends StatelessWidget {
  final QuestionItem question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              question.subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: question.tags
                  .map((tag) => Chip(
                label: Text(tag),
                backgroundColor: Colors.grey[200],
                labelStyle: const TextStyle(fontSize: 13),
              ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.thumb_up_alt_outlined, size: 18),
                const SizedBox(width: 4),
                Text('${question.likes}'),
                const SizedBox(width: 16),
                const Icon(Icons.chat_bubble_outline, size: 18),
                const SizedBox(width: 4),
                Text('${question.answers} Answers'),
                const Spacer(),
                Text(
                  question.timeAgo,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
