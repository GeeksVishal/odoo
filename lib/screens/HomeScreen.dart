import 'package:flutter/material.dart';

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

// Main screen with bottom nav
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const StackItHomePage(),
    const ProfilePage(),
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
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'You'),
        ],
      ),
    );
  }
}

// Home page screen (Q&A list)
class StackItHomePage extends StatelessWidget {
  const StackItHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade700,
        centerTitle: true,
        title: const Text(
          'StackIt',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          QuestionCard(
            title: 'How to use Provider in Flutter?',
            description:
            'I’m new to state management. How does Provider work and when should I use it?',
            tags: ['flutter', 'provider', 'state-management'],
            likes: 12,
            answers: 3,
            timeAgo: '2h ago',
          ),
          SizedBox(height: 16),
          QuestionCard(
            title: 'Firebase vs Supabase for Flutter app?',
            description:
            'Which backend is better for authentication and database?',
            tags: ['flutter', 'firebase', 'supabase'],
            likes: 8,
            answers: 5,
            timeAgo: '5h ago',
          ),
        ],
      ),
    );
  }
}

// Simple profile screen
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Your Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to your profile!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// Question card widget
class QuestionCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final int likes;
  final int answers;
  final String timeAgo;

  const QuestionCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.likes,
    required this.answers,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: -8,
            children: tags
                .map(
                  (tag) => Chip(
                label: Text(tag),
                backgroundColor: Colors.grey[200],
                labelStyle: const TextStyle(fontSize: 13),
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            )
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.thumb_up_alt_outlined, size: 18),
              const SizedBox(width: 4),
              Text('$likes'),
              const SizedBox(width: 16),
              const Icon(Icons.chat_bubble_outline, size: 18),
              const SizedBox(width: 4),
              Text('$answers Answers'),
              const Spacer(),
              Text(
                timeAgo,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
