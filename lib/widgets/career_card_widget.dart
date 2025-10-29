// widgets/career_card_widget.dart
import 'package:flutter/material.dart';

class CareerCard extends StatelessWidget {
  final String title;
  final String description;
  final int matchScore;
  final List<String> skills;
  final List<String> interests;
  final String salaryRange;
  final String demand;
  final bool isTopMatch;

  const CareerCard({
    super.key,
    required this.title,
    required this.description,
    required this.matchScore,
    required this.skills,
    required this.interests,
    required this.salaryRange,
    required this.demand,
    this.isTopMatch = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isTopMatch ? const Color(0xFF6366F1) : Colors.grey[200]!,
          width: isTopMatch ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Match Badge
          if (isTopMatch)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withAlpha(25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 14, color: Color(0xFF6366F1)),
                  const SizedBox(width: 4),
                  const Text(
                    'Top Career Match',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                ],
              ),
            ),

          if (isTopMatch) const SizedBox(height: 12),

          // Title and Match Score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getMatchColor().withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$matchScore% match',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _getMatchColor(),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          // Why This Career Fits You
          const Text(
            'Why This Career Fits You',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),

          const SizedBox(height: 12),

          // Skills Alignment
          _buildSection(
            icon: Icons.check_circle,
            iconColor: const Color(0xFF10B981),
            title: 'Skills Alignment',
            subtitle:
                'Your creative problem-solving and analytical skills are perfectly suited for strategic design roles.',
            tags: skills,
            tagColor: const Color(0xFF10B981),
          ),

          const SizedBox(height: 12),

          // Interest Match
          _buildSection(
            icon: Icons.favorite,
            iconColor: const Color(0xFF6366F1),
            title: 'Interest Match',
            subtitle:
                'Your passion for visual design and business strategy creates the perfect foundation.',
            tags: interests,
            tagColor: const Color(0xFF6366F1),
          ),

          const SizedBox(height: 12),

          // Growth Potential
          _buildSection(
            icon: Icons.trending_up,
            iconColor: const Color(0xFFEC4899),
            title: 'Growth Potential',
            subtitle:
                'High demand field with excellent salary prospects and career advancement opportunities.',
            tags: [salaryRange, demand],
            tagColor: const Color(0xFFEC4899),
          ),

          const SizedBox(height: 16),

          // Explore More Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Navigate to detailed career page
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF6366F1)),
                foregroundColor: const Color(0xFF6366F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Explore More',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required List<String> tags,
    required Color tagColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((tag) => _buildTag(tag, tagColor)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Color _getMatchColor() {
    if (matchScore >= 90) return const Color(0xFF10B981);
    if (matchScore >= 80) return const Color(0xFF6366F1);
    return const Color(0xFFF59E0B);
  }
}
