import 'package:flutter/material.dart';
import 'onboarding_step3.dart';
import 'completion_screen.dart';

class OnboardingStep2 extends StatefulWidget {
  final String role;

  const OnboardingStep2({super.key, required this.role});

  @override
  State<OnboardingStep2> createState() => _OnboardingStep2State();
}

class _OnboardingStep2State extends State<OnboardingStep2> {
  String _selectedProfession = '';

  final List<Map<String, dynamic>> _professions = [
    {
      'icon': Icons.code,
      'title': 'Software Developer',
      'subtitle': 'Frontend, Backend, Full Stack',
      'color': const Color(0xFF6366F1),
    },
    {
      'icon': Icons.business_center,
      'title': 'Business/Management',
      'subtitle': 'Strategy, Analysis, Ops',
      'color': const Color(0xFF10B981),
    },
    {
      'icon': Icons.palette,
      'title': 'Designer',
      'subtitle': 'UI/UX, Visual Design',
      'color': const Color(0xFFF59E0B),
    },
    {
      'icon': Icons.school,
      'title': 'University Professor',
      'subtitle': 'Teaching, Research',
      'color': const Color(0xFFEC4899),
    },
    {
      'icon': Icons.medical_services,
      'title': 'Healthcare',
      'subtitle': 'Doctor, Pharma',
      'color': const Color(0xFFEF4444),
    },
  ];

  void _continue() {
    if (_selectedProfession.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your profession')),
      );
      return;
    }

    if (widget.role == 'Professional') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => CompletionScreen(
            role: widget.role,
            profession: _selectedProfession,
            grade: 'Not Applicable', // No grade for professionals
          ),
        ),
        (route) => false,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingStep3(
            role: widget.role,
            profession: _selectedProfession,
          ),
        ),
      );
    }
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
                widget.role == 'Professional' ? '2 of 2' : '2 of 3',
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
                "What's your profession?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This will help us personalize your experience and\nconnect you with the right resources',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: _professions.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _professions.length) {
                      return _buildOtherOption();
                    }
                    final profession = _professions[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildProfessionCard(
                        icon: profession['icon'],
                        title: profession['title'],
                        subtitle: profession['subtitle'],
                        color: profession['color'],
                        isSelected: _selectedProfession == profession['title'],
                        onTap: () => setState(
                          () => _selectedProfession = profession['title'],
                        ),
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
                    'Finish',
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

  Widget _buildProfessionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(25) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withAlpha(51),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
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
                      color: isSelected ? color : Colors.black,
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
            if (isSelected) Icon(Icons.check_circle, color: color, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherOption() {
    return InkWell(
      onTap: () => setState(() => _selectedProfession = 'Other'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _selectedProfession == 'Other'
              ? const Color(0xFF6366F1).withAlpha(25)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _selectedProfession == 'Other'
                ? const Color(0xFF6366F1)
                : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.add, color: Colors.grey[700], size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Other',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _selectedProfession == 'Other'
                          ? const Color(0xFF6366F1)
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Specify your profession',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            if (_selectedProfession == 'Other')
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
