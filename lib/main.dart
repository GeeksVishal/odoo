import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:odoo/screens/HomeScreen.dart';
import 'package:odoo/screens/Login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const SuggestionHubApp());
}

class SuggestionHubApp extends StatelessWidget {
  const SuggestionHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suggestion Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(), // start with login screen
    );
  }
}
