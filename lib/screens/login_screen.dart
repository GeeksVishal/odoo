import 'package:flutter/material.dart';
import 'package:odoo/screens/forget_screen.dart';
import 'package:odoo/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _Login() {

  }

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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hint: Text('Enter Email'),
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgetScreen()),
                      );
                    },
                    child: Text("Forget Password ?"),
                  ),
                ],
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
                  child: Text('Login'),
                ),
              ),
              SizedBox(height: 20,),
              Text("don't have account ?"),
              SizedBox(height: 10,),
              InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));},
                  child: Text("Sign Up",style: TextStyle(color: Colors.blue),))
            ],
          ),
        ),
      ),
    );
  }
}
