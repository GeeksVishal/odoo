import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:odoo/screens/NewPostScreen.dart';

import 'Login_screen.dart';

void main() {
  runApp(const StackItApp());
}

class StackItApp extends StatelessWidget {
  const StackItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StackIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(),
    );
  }
}

/// ---------------------- MAIN SCREEN ----------------------
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    StackItHomePage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            label: 'You',
          ),
        ],
      ),
    );
  }
}

/// ---------------------- HOME PAGE ----------------------
class StackItHomePage extends StatefulWidget {
  const StackItHomePage({super.key});

  @override
  State<StackItHomePage> createState() => _StackItHomePageState();
}

class _StackItHomePageState extends State<StackItHomePage> {
  final List<QuestionData> _questions = [
    QuestionData(
      title: 'How to use Provider in Flutter?',
      description: 'I’m new to state management. How does Provider work and when should I use it?',
      tags: ['flutter', 'provider', 'state-management'],
      likes: 12,
      answers: 3,
      timeAgo: '2h ago',
    ),
    QuestionData(
      title: 'Firebase vs Supabase for Flutter app?',
      description: 'Which backend is better for authentication and database?',
      tags: ['flutter', 'firebase', 'supabase'],
      likes: 8,
      answers: 5,
      timeAgo: '5h ago',
    ),
  ];

  void _openAddDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewPostScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StackIt'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _questions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, i) => QuestionCard(data: _questions[i]),
      ),
    );
  }
}

/// ---------------------- QUESTION CARD DATA ----------------------
class QuestionData {
  final String title;
  final String description;
  final List<String> tags;
  final int likes;
  final int answers;
  final String timeAgo;

  QuestionData({
    required this.title,
    required this.description,
    required this.tags,
    required this.likes,
    required this.answers,
    required this.timeAgo,
  });
}

/// ---------------------- QUESTION CARD UI ----------------------
class QuestionCard extends StatelessWidget {
  final QuestionData data;
  const QuestionCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(data.description, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: data.tags.map(
                    (tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(tag, style: const TextStyle(fontSize: 12)),
                ),
              ).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.thumb_up_alt_outlined, size: 16),
                const SizedBox(width: 4),
                Text('${data.likes}'),
                const SizedBox(width: 16),
                const Icon(Icons.chat_bubble_outline, size: 16),
                const SizedBox(width: 4),
                Text('${data.answers} Answers'),
                const Spacer(),
                Text(data.timeAgo, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------- PROFILE PAGE ----------------------
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Your Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
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
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Join The Community',
                          style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>  LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child:GestureDetector(
                      child: Text('Sign Out'
                      )
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.feedback_outlined, color: Colors.blue),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.share_outlined, color: Colors.blue),
                title: const Text('Grow together!'),
                subtitle: const Text('Share our app and help others solve their problems.'),
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
