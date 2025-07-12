import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:odoo/screens/Login_screen.dart';
import 'HomeScreen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signup(BuildContext context) async {
    print("Sign-Up button clicked");

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Success
      print("Sign-Up success: ${userCredential.user?.email}");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  StackItHomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'That email is already registered.';
          break;
        case 'invalid-email':
          message = 'The email address is invalid.';
          break;
        case 'weak-password':
          message = 'The password is too weak.';
          break;
        default:
          message = e.message ?? 'Registration failed.';
      }

      print("Sign-Up error: $message");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      print("Sign-Up error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation_3.json',
                  width: 350,
                  height: 190,
                  repeat: true, // Loop animation
                  animate: true, // Play animation
                ),
                const SizedBox(height: 40),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Sign Up", style: TextStyle(fontSize: 50),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: "Enter Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () => _signup(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
                const SizedBox(height: 15),
                const Text("Already have an account?"),
                const SizedBox(height: 13),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  child: const Text("Login", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
