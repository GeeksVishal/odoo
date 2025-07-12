import 'package:flutter/material.dart';

class ForgetScreen extends StatelessWidget {
  final TextEditingController controller=TextEditingController();

  ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Enter Current Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
