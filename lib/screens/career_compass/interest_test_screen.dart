// screens/career_compass/interest_test_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/screens/career_compass/loading_screen.dart';
import '../../data/questions_data.dart';
import '../../providers/assessment_provider.dart';

class InterestTestScreen extends ConsumerStatefulWidget {
  const InterestTestScreen({super.key});

  @override
  ConsumerState<InterestTestScreen> createState() => _InterestTestScreenState();
}

class _InterestTestScreenState extends ConsumerState<InterestTestScreen> {
  int currentQuestionIndex = 0;
  int? selectedRating;

  void _selectRating(int rating) {
    setState(() {
      selectedRating = rating;
    });
  }

  void _nextQuestion() {
    if (selectedRating == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a rating')));
      return;
    }

    final currentQuestion =
        QuestionsData.interestQuestions[currentQuestionIndex];
    ref
        .read(assessmentProvider.notifier)
        .answerInterestQuestion(currentQuestion.id, selectedRating!);

    if (currentQuestionIndex < QuestionsData.interestQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedRating = null;
      });
    } else {
      // Navigate to AI Loading Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AILoadingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = QuestionsData.interestQuestions[currentQuestionIndex];
    final progress =
        (currentQuestionIndex + 1) / QuestionsData.interestQuestions.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Question ${currentQuestionIndex + 1} of ${QuestionsData.interestQuestions.length}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Interest Assessment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Part 2 of 2: Let\'s discover which activities you prefer.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF10B981),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Question and Rating Scale
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2937),
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    'How much does this describe you?',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                  ),

                  const SizedBox(height: 24),

                  // Rating Scale (1-5)
                  Column(
                    children: [
                      _buildRatingOption(1, 'Strongly Disagree'),
                      const SizedBox(height: 12),
                      _buildRatingOption(2, 'Disagree'),
                      const SizedBox(height: 12),
                      _buildRatingOption(3, 'Neutral'),
                      const SizedBox(height: 12),
                      _buildRatingOption(4, 'Agree'),
                      const SizedBox(height: 12),
                      _buildRatingOption(5, 'Strongly Agree'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(25),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          currentQuestionIndex--;
                          selectedRating = null;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF6366F1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Previous',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                    ),
                  ),
                if (currentQuestionIndex > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: Text(
                      currentQuestionIndex ==
                              QuestionsData.interestQuestions.length - 1
                          ? 'Get My Results'
                          : 'Next',
                      style: const TextStyle(
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
        ],
      ),
    );
  }

  Widget _buildRatingOption(int rating, String label) {
    final isSelected = selectedRating == rating;

    return GestureDetector(
      onTap: () => _selectRating(rating),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF10B981).withAlpha(25)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF10B981) : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF10B981)
                      : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected ? const Color(0xFF10B981) : Colors.white,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFF10B981)
                      : const Color(0xFF1F2937),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
