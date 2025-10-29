import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/screens/career_compass/welcome_screen.dart';
import 'package:myapp/screens/college_predictor/predictor_home_screen.dart';
import 'package:myapp/screens/comparator/compare_colleges_screen.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/main_screen.dart';

void main() {
  runApp(const ProviderScope(child: MargadarshakApp()));
}

class MargadarshakApp extends StatelessWidget {
  const MargadarshakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Margadarshak',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Inter',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          primary: const Color(0xFF6366F1),
          secondary: const Color(0xFF10B981),
        ),
      ),
      // Named routes for easy navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/main': (context) => const MainScreen(),
        '/career-compass': (context) => const CareerCompassWelcomeScreen(),
        '/compare-colleges': (context) => const CompareCollegesScreen(),
        '/college-predictor': (context) => const PredictorHomeScreen(),
      },
    );
  }
}
