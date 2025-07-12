import 'package:flutter/material.dart';
import '../helper/db_helper.dart';

class AnswerPage extends StatefulWidget {
  final int questionId;
  final String questionTitle;

  const AnswerPage({
    super.key,
    required this.questionId,
    required this.questionTitle,
  });

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final TextEditingController _answerController = TextEditingController();
  late Future<List<Map<String, dynamic>>> _answersFuture;

  @override
  void initState() {
    super.initState();
    _loadAnswers();
  }

  void _loadAnswers() {
    _answersFuture = DBHelper.getAnswers(widget.questionId);
    setState(() {});
  }

  Future<void> _postAnswer() async {
    final answerText = _answerController.text.trim();
    if (answerText.isEmpty) return;

    await DBHelper.insertAnswer(widget.questionId, answerText);
    _answerController.clear();
    _loadAnswers();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Answer posted")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.questionTitle),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _answersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading answers"));
                }

                final answers = snapshot.data ?? [];
                if (answers.isEmpty) {
                  return const Center(child: Text("No answers yet"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: answers.length,
                  itemBuilder: (_, i) {
                    final a = answers[i];
                    final text = a['text'] ?? '';
                    final time = a['timeAgo'] ?? '';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(text, style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 6),
                            Text(time,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _answerController,
                    decoration: const InputDecoration(
                      hintText: "Write your answer...",
                      border: OutlineInputBorder(),
                    ),
                    minLines: 1,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _postAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Post"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
