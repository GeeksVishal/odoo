import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light theme
      appBar: AppBar(
        title: const Text(
          'Plant Detector',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "user_name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Text("Join The Community"),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Feedback card
            Card(
              elevation: 3,
              color: Colors.blue.shade50,
              child: ListTile(
                leading: const Icon(Icons.feedback_outlined, color: Colors.blue),
                title: const Text("How is your experience with our app?"),
                subtitle: const Text("We love to hear your suggestions."),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text("Give Feedback"),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Share App card
            Card(
              elevation: 3,
              color: Colors.blue.shade50,
              child: ListTile(
                leading: const Icon(Icons.share, color: Colors.blue),
                title: const Text("Grow together!"),
                subtitle: const Text(
                    "Share our app and help farmers solve their plant problems."),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text("Share App"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
