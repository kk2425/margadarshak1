// screens/career_compass/ai_personalization_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'results_screen.dart';

class AIPersonalizationScreen extends ConsumerStatefulWidget {
  const AIPersonalizationScreen({super.key});

  @override
  ConsumerState<AIPersonalizationScreen> createState() =>
      _AIPersonalizationScreenState();
}

class _AIPersonalizationScreenState
    extends ConsumerState<AIPersonalizationScreen> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<String> _questions = [
    'Think about a project you were really proud of, where you got to build, design, or create something. What part did you enjoy most: coming up with the initial concept, figuring out the technical details and how to make it work, or seeing your finished creation come to life?',
    'When you\'re faced with a tricky problem that requires a solution – maybe fixing something, optimizing a process, or solving a complex puzzle – what\'s your first instinct? Do you prefer to analyze all the components and plan a step-by-step approach, or do you like to experiment with different ideas and see what works best?',
    'Imagine you\'re working on a team project to create something, like designing a new product or building a complex model. What role do you naturally find yourself taking: being the creative one who brainstorms initial concepts, the detail-oriented person who ensures everything is technically sound, or the one who focuses on the practical execution and organization?',
  ];

  bool _isLoading = false;

  void _generateResults() async {
    // Validate that all fields are filled
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please answer question ${i + 1}')),
        );
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate AI processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Store answers (you can add to provider if needed)
      final _ = _controllers.map((c) => c.text).toList();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResultsScreen()),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          'AI Personalization',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF6366F1)),
                  SizedBox(height: 24),
                  Text(
                    'Analyzing your responses...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Final Step: AI Personalization',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Answer these questions for a more tailored recommendation.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 32),

                  // Questions
                  ...List.generate(
                    _questions.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: _buildQuestionField(
                        index + 1,
                        _questions[index],
                        _controllers[index],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Generate Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _generateResults,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Generate My Career Matches',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildQuestionField(
    int number,
    String question,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1F2937),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: controller,
            maxLines: 4,
            style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
            decoration: const InputDecoration(
              hintText: 'Your thoughts here...',
              hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}
