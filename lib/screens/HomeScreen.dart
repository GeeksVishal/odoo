import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helper/db_helper.dart';
import 'Login_screen.dart';
import 'NewPostScreen.dart';
import 'answer_page.dart';

class StackItHomePage extends StatefulWidget {
  const StackItHomePage({super.key});

  @override
  State<StackItHomePage> createState() => _StackItHomePageState();
}

class _StackItHomePageState extends State<StackItHomePage> {
  Future<List<Map<String, dynamic>>>? _questionFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _refreshQuestions();
  }

  void _refreshQuestions() {
    _questionFuture = DBHelper.getQuestions();
    setState(() {});
  }

  Future<void> _openNewPost() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewPostScreen()),
    );
    if (result != null) _refreshQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StackIt", style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.blue,),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.blue,),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Sort clicked")),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'refresh') _refreshQuestions();
            }, icon: Icon(Icons.more_vert, color: Colors.blue,),
            itemBuilder: (context) =>
            [
              const PopupMenuItem(
                value: 'refresh',
                child: Text('Refresh'),
              ),
              const PopupMenuItem(
                value: 'about',
                child: Text('About'),
              ),
            ],
          ),
        ],
      ),
      body: _selectedIndex == 0 ? buildHome() : buildProfile(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openNewPost,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                    color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
                onPressed: () => setState(() => _selectedIndex = 0),
              ),
              const SizedBox(width: 48),
              IconButton(
                icon: Icon(Icons.person,
                    color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
                onPressed: () => setState(() => _selectedIndex = 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHome() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _questionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }

        final data = snapshot.data ?? [];
        if (data.isEmpty) {
          return const Center(child: Text('No posts yet'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: data.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (_, i) {
            final q = data[i];
            return QuestionCard(
              title: q['title'],
              description: q['description'],
              tags: ['flutter'],
              // Optional: use actual tags if stored
              likes: q['likes'],
              answers: q['answers'],
              timeAgo: q['timeAgo'],
              questionId: q['id'],
              onLike: () async {
                await DBHelper.incrementLike(q['id']);
                _refreshQuestions();
              },
              onDelete: () async {
                await DBHelper.deleteQuestion(q['id']);
                _refreshQuestions();
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AnswerPage(
                          questionId: q['id'],
                          questionTitle: q['title'],
                        ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget buildProfile() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('user_name',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Join The Community',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey[700])),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Sign Out'),
                )
              ],
            ),
            const SizedBox(height: 32),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: ListTile(
                leading: const Icon(
                    Icons.feedback_outlined, color: Colors.blue),
                title: const Text('How is Your experience with our app?'),
                subtitle: const Text('We love to hear your suggestions.'),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('Give Feedback'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.share_outlined, color: Colors.blue),
                title: const Text('Grow together!'),
                subtitle: const Text(
                    'Share our app and help others solve their problems.'),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('Share App'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final int likes;
  final int answers;
  final String timeAgo;
  final int questionId;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final VoidCallback? onLike;

  const QuestionCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.likes,
    required this.answers,
    required this.timeAgo,
    required this.questionId,
    this.onDelete,
    this.onTap,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description,
              style: TextStyle(fontSize: 14, color: Colors.grey[800])),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: tags
                .map((t) =>
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(t, style: const TextStyle(fontSize: 12)),
                ))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.thumb_up_alt_outlined, size: 16),
                onPressed: onLike,
              ),
              const SizedBox(width: 4),
              Text('$likes'),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.message, size: 16),
                onPressed: onTap, // ✅ Only this opens AnswerPage
              ),
              const SizedBox(width: 4),
              Text('$answers Answers'),
              const Spacer(),
              Text(timeAgo,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ]),
      ),
    );
  }
}

// 🔍 Search Delegate
class DataSearch extends SearchDelegate<String> {
  final recent = <String>[];
  final allData = ["Firebase", "State", "UI", "Animations"];

  @override
  List<Widget> buildActions(BuildContext context) =>
      [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(BuildContext context) =>
      Center(child: Text("You searched: $query"));

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recent
        : allData
        .where((p) => p.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (_, i) =>
          ListTile(
            title: Text(suggestionList[i]),
            onTap: () {
              query = suggestionList[i];
              showResults(context);
            },
          ),
    );
  }
}
