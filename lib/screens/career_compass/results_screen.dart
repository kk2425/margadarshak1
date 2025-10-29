// screens/career_compass/results_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/assessment_provider.dart';
import '../../widgets/radar_chart_widget.dart';
import '../../widgets/career_card_widget.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assessmentState = ref.watch(assessmentProvider);
    final aptitudeScores = assessmentState.aptitudeScores;
    final interestScores = assessmentState.interestScores;

    if (aptitudeScores == null || interestScores == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Career Results',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Show options menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            
            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Your Career Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Based on your assessments, here are your top 5 AI-powered career recommendations.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Radar Charts Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // Aptitude Chart
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Aptitude Scores',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: AptitudeRadarChart(scores: aptitudeScores),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Interest Chart
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Interest Profile (RIASEC)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: InterestRadarChart(scores: interestScores),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Top Career Matches Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Top 5 Career Matches',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Career Cards
            CareerCard(
              title: 'Industrial Designer',
              description: 'Industrial designers shape the aesthetics, ergonomics, and usability of manufactured products. You\'ll move from concept sketches to 3D models, collaborating with engineers to bring new ideas to life, creating everything from furniture to consumer electronics.',
              matchScore: 92,
              skills: ['Creative Thinking', 'Problem Solving', 'Strategic Planning'],
              interests: ['Design', 'Innovation', 'Leadership'],
              salaryRange: '\$85k-150k',
              demand: 'High Demand',
              isTopMatch: true,
            ),
            
            const SizedBox(height: 16),
            
            CareerCard(
              title: 'Architectural Designer',
              description: 'Architectural designers assist in the conceptualization and development of building projects, translating initial ideas into visual plans and models. This path allows you to creatively solve spatial puzzles and contribute to structures that stand the test of time.',
              matchScore: 89,
              skills: ['Spatial Reasoning', 'Technical Drawing', 'Collaboration'],
              interests: ['Architecture', 'Design', 'Engineering'],
              salaryRange: '\$75k-130k',
              demand: 'High Demand',
            ),
            
            const SizedBox(height: 16),
            
            CareerCard(
              title: 'Game Level Designer',
              description: 'Level designers are the architects of virtual worlds, building the playable spaces, puzzles, and experiences within a game. You\'ll bring stories and challenges to life through interactive design, constantly innovating new scenarios for players.',
              matchScore: 88,
              skills: ['Creative Design', '3D Modeling', 'User Experience'],
              interests: ['Gaming', 'Creativity', 'Technology'],
              salaryRange: '\$70k-140k',
              demand: 'Remote Friendly',
            ),
            
            const SizedBox(height: 16),
            
            CareerCard(
              title: 'UX Research',
              description: 'UX researchers study user behavior and preferences to inform product design decisions. You\'ll conduct interviews, usability tests, and data analysis to create user-centered experiences.',
              matchScore: 85,
              skills: ['Research', 'Analysis', 'Communication'],
              interests: ['User Experience', 'Psychology', 'Data'],
              salaryRange: '\$80k-145k',
              demand: 'High Demand',
            ),
            
            const SizedBox(height: 16),
            
            CareerCard(
              title: 'Product Management',
              description: 'Product managers guide the development and success of products, from conception to launch. You\'ll work cross-functionally to define product vision, prioritize features, and deliver value to users.',
              matchScore: 85,
              skills: ['Strategy', 'Leadership', 'Communication'],
              interests: ['Business', 'Technology', 'Innovation'],
              salaryRange: '\$90k-160k',
              demand: 'High Demand',
            ),
            
            const SizedBox(height: 32),
            
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Download PDF functionality
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Download PDF Report'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF6366F1)),
                        foregroundColor: const Color(0xFF6366F1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to AI chat or explore more
                      },
                      icon: const Icon(Icons.explore),
                      label: const Text('Explore More Careers'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // AI Counselor Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Go Deeper with Your AI Counselor',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Your journey doesn\'t end here. Chat with Compass AI to explore these roles, ask about other careers, or get specific advice on your next steps.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to AI Chat screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF6366F1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Start Chat',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}