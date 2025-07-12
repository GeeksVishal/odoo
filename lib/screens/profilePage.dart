import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Login_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

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
                      Text(
                        user?.email ?? 'Anonymous User',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
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
