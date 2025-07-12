import 'package:flutter/material.dart';

class ForgetScreen extends StatelessWidget {
  final TextEditingController controller=TextEditingController();

  ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 100, color: Colors.blue),
              SizedBox(height: 40),
              TextField(
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: 180,
                height: 40,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white, // Text color// Border color
                    backgroundColor: Colors.blue, // Background color (optional)
                  ),
                  child: Text('Forget Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
