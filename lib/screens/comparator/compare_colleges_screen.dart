// screens/comparator/compare_colleges_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/college_comparator_provider.dart';
import '../../models/college_comparator_models.dart';
import 'search_colleges_screen.dart';

class CompareCollegesScreen extends ConsumerWidget {
  const CompareCollegesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColleges = ref.watch(selectedCollegesProvider);

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
          'Compare Colleges',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
      ),
      body: selectedColleges.isEmpty
          ? _buildEmptyState(context, ref)
          : SingleChildScrollView(
              child: Column(
                children: [
                  // College Selection Row
                  _buildCollegeSelectionRow(context, ref, selectedColleges),
                  
                  const SizedBox(height: 16),
                  
                  // Comparison Table
                  _buildComparisonTable(selectedColleges),
                  
                  const SizedBox(height: 24),
                  
                  // Actions
                  _buildActions(context, ref),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.compare_arrows,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            const Text(
              'Start Comparing Colleges',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Select up to 3 colleges to compare their features side by side',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchCollegesScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Colleges'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollegeSelectionRow(
    BuildContext context,
    WidgetRef ref,
    List<CollegeDetail> colleges,
  ) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: List.generate(3, (index) {
          if (index < colleges.length) {
            return Expanded(
              child: _buildCollegeSelector(
                context,
                ref,
                colleges[index],
                index,
                isSelected: true,
              ),
            );
          } else {
            return Expanded(
              child: _buildCollegeSelector(
                context,
                ref,
                null,
                index,
                isSelected: false,
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildCollegeSelector(
    BuildContext context,
    WidgetRef ref,
    CollegeDetail? college,
    int index,
    {required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: isSelected && college != null
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Select College ${index + 1}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ref.read(selectedCollegesProvider.notifier).removeCollege(college.id);
                      },
                      child: Icon(Icons.close, size: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withAlpha(25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(Icons.school, color: Color(0xFF6366F1)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        college.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchCollegesScreen(slotIndex: index),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select College ${index + 1}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add, color: Colors.grey),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildComparisonTable(List<CollegeDetail> colleges) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildComparisonRow('Attribute', colleges.map((c) => c.name).toList(), isHeader: true),
          const Divider(height: 1),
          _buildComparisonRow('Cutoff Rank', colleges.map((c) => c.cutoffRank).toList()),
          _buildComparisonRow('JEE Advanced', colleges.map((c) => c.cutoffRank).toList()),
          const Divider(height: 1),
          _buildComparisonRow('Category', colleges.map((c) => c.category).toList()),
          const Divider(height: 1),
          _buildComparisonRow('Accreditation', colleges.map((c) => c.accreditation).toList()),
          const Divider(height: 1),
          _buildComparisonRow('Annual Fees', colleges.map((c) => c.annualFees).toList()),
          _buildComparisonRow('2023 Batch', colleges.map((c) => c.annualFees).toList()),
          const Divider(height: 1),
          _buildComparisonRow('Avg Package', colleges.map((c) => c.avgPackage).toList()),
          _buildComparisonRow('2023 Batch', colleges.map((c) => c.avgPackage).toList()),
          const Divider(height: 1),
          _buildComparisonRow('Facilities', colleges.map((c) => c.facilities).toList()),
          const Divider(height: 1),
          _buildComparisonRow(
            'Campus Rating',
            colleges.map((c) => '${c.campusRating} ⭐').toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String label, List<String> values, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: isHeader ? 13 : 12,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
                color: isHeader ? const Color(0xFF1F2937) : const Color(0xFF6B7280),
              ),
            ),
          ),
          ...List.generate(
            3,
            (index) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  index < values.length ? values[index] : '-',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isHeader ? 11 : 12,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
                    color: isHeader ? const Color(0xFF1F2937) : const Color(0xFF374151),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F9FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF6366F1), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AI Recommendation',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      Text(
                        'All 3 quality offers similar ROI based on your profile',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF6366F1)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchCollegesScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF6366F1)),
                    foregroundColor: const Color(0xFF6366F1),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Apply Now'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchCollegesScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('Apply Now'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Save comparison
            },
            icon: const Icon(Icons.download_outlined),
            label: const Text('Save Comparison'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () {
              // Share
            },
            icon: const Icon(Icons.share_outlined),
            label: const Text('Share'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF6366F1),
            ),
          ),
        ],
      ),
    );
  }
}