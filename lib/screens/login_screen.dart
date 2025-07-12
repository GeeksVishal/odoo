import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController 
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Icon(
                  Icons.home,
                  size: 100,
                  color: Colors.blue,
                  ),
                  SizedBox(height: 40,),
                  TextField(
                    
                  )
            ],
          ),
        ),
      );
  }
}
