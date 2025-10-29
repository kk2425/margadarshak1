// screens/onboarding_step3.dart
import 'package:flutter/material.dart';
import 'completion_screen.dart';

class OnboardingStep3 extends StatefulWidget {
  final String role;
  final String profession;

  const OnboardingStep3({
    super.key,
    required this.role,
    required this.profession,
  });

  @override
  State<OnboardingStep3> createState() => _OnboardingStep3State();
}

class _OnboardingStep3State extends State<OnboardingStep3> {
  String _selectedGrade = '';

  final List<Map<String, String>> _grades = [
    {'title': '10th Grade', 'subtitle': 'Secondary Education'},
    {'title': '12th Grade', 'subtitle': 'Higher Secondary'},
    {'title': 'Graduate (UG)', 'subtitle': 'Undergraduate Degree'},
    {'title': 'Postgraduate (PG)', 'subtitle': 'Master\'s Degree'},
  ];

  void _continue() {
    if (_selectedGrade.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select your grade')));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompletionScreen(
          role: widget.role,
          profession: widget.profession,
          grade: _selectedGrade,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '2 of 2',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Which grade are you in?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Help us personalize your learning experience by\nselecting your current academic level',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: _grades.length,
                  itemBuilder: (context, index) {
                    final grade = _grades[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildGradeCard(
                        title: grade['title']!,
                        subtitle: grade['subtitle']!,
                        isSelected: _selectedGrade == grade['title'],
                        onTap: () =>
                            setState(() => _selectedGrade = grade['title']!),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradeCard({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6366F1).withAlpha(25)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF6366F1) : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school_outlined,
                color: isSelected ? Colors.white : Colors.grey[700],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF6366F1),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
