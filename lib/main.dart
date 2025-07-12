import 'package:flutter/material.dart';

void main() {
  runApp(const SuggestionHubApp());
}

class SuggestionHubApp extends StatelessWidget {
  const SuggestionHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suggestion Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const SuggestionHubPage(),
    );
  }
}

class SuggestionHubPage extends StatelessWidget {
  const SuggestionHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Suggestion ',
                style: TextStyle(color: Colors.greenAccent),
              ),
              TextSpan(text: 'Hub'),
            ],
          ),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 12),
          Icon(Icons.filter_list),
          SizedBox(width: 12),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: 5,
        itemBuilder: (context, index) {
          return const SuggestionCard();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle new post creation
        },
        backgroundColor: Colors.green.shade700,
        icon: const Icon(Icons.add),
        label: const Text('New Post'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1C1C1C),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: 'your crop'),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'Suggestion Hub'),
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Knowledge Hub'),
          BottomNavigationBarItem(icon: Icon(Icons.car_repair_outlined), label: 'Vehicle Hub'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'You'),
        ],
      ),
    );
  }
}

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1C1C1C),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Center(
              child: Icon(Icons.camera_alt_outlined, color: Colors.white38, size: 60),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.green.shade900.withOpacity(0.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Icon(Icons.account_circle, color: Colors.lightGreenAccent, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'User_Name',
                      style: TextStyle(color: Colors.lightGreenAccent, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Question_title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Question_Description',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
