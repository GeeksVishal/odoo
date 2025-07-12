import 'package:flutter/material.dart';
import 'package:odoo/screens/HomeScreen.dart';
import 'package:odoo/screens/Login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SuggestionHubApp());
}

class SuggestionHubApp extends StatelessWidget {
  const SuggestionHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}
