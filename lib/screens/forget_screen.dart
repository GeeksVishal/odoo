import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
              Lottie.asset('assets/animation_2.json',
                width: 350,
                height: 290,
                repeat: true, // Loop animation
                animate: true, // Play animation
              ),
              const SizedBox(height: 40),
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Forget Passwords", style: TextStyle(fontSize: 40),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email,color: Colors.blue,),
                  ),
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
