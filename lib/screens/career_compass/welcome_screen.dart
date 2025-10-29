// screens/career_compass/welcome_screen.dart
import 'package:flutter/material.dart';
import 'aptitude_test_screen.dart';

class CareerCompassWelcomeScreen extends StatelessWidget {
  const CareerCompassWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Compass Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.explore_outlined,
                  size: 60,
                  color: Color(0xFF6366F1),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title
              const Text(
                'Welcome to Career Compass AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Description
              Text(
                'Discover your ideal career path. This tool analyzes your unique aptitudes and interests to provide personalized recommendations, with optional AI-powered guidance for a deeper dive.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Info Cards
              _buildInfoCard(
                icon: Icons.quiz_outlined,
                title: 'Total Questions',
                subtitle: '10-15 questions',
                color: const Color(0xFF6366F1),
              ),
              
              const SizedBox(height: 16),
              
              _buildInfoCard(
                icon: Icons.timer_outlined,
                title: 'Duration',
                subtitle: 'Takes 5-7 mins',
                color: const Color(0xFF10B981),
              ),
              
              const SizedBox(height: 16),
              
              _buildInfoCard(
                icon: Icons.analytics_outlined,
                title: 'Result',
                subtitle: 'Personalized at end',
                color: const Color(0xFFEC4899),
              ),
              
              const Spacer(),
              
              // Start Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AptitudeTestScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Find My Career Path',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}