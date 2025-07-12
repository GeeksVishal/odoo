import 'package:flutter/material.dart';
import 'package:odoo/screens//Login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body:
      Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 40),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hint: Text("Enter Email"),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email,color: Colors.blue,),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock,color: Colors.blue,),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 150,
                height: 40,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white, // Text color// Border color
                    backgroundColor: Colors.blue, // Background color (optional)
                  ),
                  child: Text('Sign Up'),
                ),
              ),
SizedBox(height: 15,),
Text("Already Have Account ?"),
              SizedBox(height: 13,),
              InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));},
                child: Text("Login",style: TextStyle(color: Colors.blue),))
            ],
          ),
        ),
      ),
    );
  }
}
