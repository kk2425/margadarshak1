// screens/career_compass/ai_loading_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'ai_personalization_screen.dart';

class AILoadingScreen extends ConsumerStatefulWidget {
  const AILoadingScreen({super.key});

  @override
  ConsumerState<AILoadingScreen> createState() => _AILoadingScreenState();
}

class _AILoadingScreenState extends ConsumerState<AILoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(_animationController);
    
    // Simulate AI processing time (2-3 seconds)
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AIPersonalizationScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated dots
              FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(delay: 0),
                    const SizedBox(width: 12),
                    _buildDot(delay: 200),
                    const SizedBox(width: 12),
                    _buildDot(delay: 400),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              const Text(
                'Generating personalized questions...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              
              const SizedBox(height: 12),
              
              Text(
                'Analyzing your unique profile',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot({required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + delay),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(
              const Color(0xFF6366F1).withAlpha(77),
              const Color(0xFF6366F1),
              value,
            ),
          ),
        );
      },
    );
  }
}