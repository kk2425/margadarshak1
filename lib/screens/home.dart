
import 'package:flutter/material.dart';
import 'package:myapp/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Here you can add logic to determine whether to show the login screen
    // or the main screen. For example, you can check if the user is logged in.
    // For now, we'll just show the login screen.
    return const LoginScreen();
  }
}
