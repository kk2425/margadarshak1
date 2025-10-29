// screens/comparator/filter_colleges_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/college_comparator_provider.dart';

class FilterCollegesScreen extends ConsumerWidget {
  const FilterCollegesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(collegeFiltersProvider);
    final filteredCollegesCount = ref.watch(filteredCollegesProvider).length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const Text(
              'Filter Colleges',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              '$filteredCollegesCount colleges',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Select Branch
                  _buildSectionTitle(Icons.school, 'Select Branch'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        [
                          'CSE',
                          'IT',
                          'ENTC',
                          'Mechanical',
                          'Civil',
                          'Chemical',
                        ].map((branch) {
                          final isSelected = filters.selectedBranches.contains(
                            branch,
                          );
                          return _buildFilterChip(
                            branch,
                            isSelected,
                            () => ref
                                .read(collegeFiltersProvider.notifier)
                                .toggleBranch(branch),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Choose Region
                  _buildSectionTitle(Icons.location_on, 'Choose Region'),
                  const SizedBox(height: 12),
                  Column(
                    children: ['Mumbai', 'Pune', 'Nashik', 'Nagpur', 'Others']
                        .map((region) {
                          final isSelected = filters.selectedRegions.contains(
                            region,
                          );
                          return _buildCheckboxTile(
                            region,
                            isSelected,
                            () => ref
                                .read(collegeFiltersProvider.notifier)
                                .toggleRegion(region),
                          );
                        })
                        .toList(),
                  ),

                  const SizedBox(height: 24),

                  // College Type
                  _buildSectionTitle(Icons.business, 'College Type'),
                  const SizedBox(height: 12),
                  Column(
                    children:
                        ['Government', 'Private', 'Autonomous', 'Minority'].map(
                          (type) {
                            final isSelected = filters.selectedCollegeTypes
                                .contains(type);
                            return _buildCheckboxTile(
                              type,
                              isSelected,
                              () => ref
                                  .read(collegeFiltersProvider.notifier)
                                  .toggleCollegeType(type),
                            );
                          },
                        ).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Tuition Fee Range
                  _buildSectionTitle(
                    Icons.currency_rupee,
                    'Tuition Fee Range (per year)',
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: [
                      _buildRadioTile(
                        'Low',
                        '< ₹50,000',
                        filters.tuitionFeeRange == 'Low',
                        () => ref
                            .read(collegeFiltersProvider.notifier)
                            .setTuitionFeeRange('Low'),
                      ),
                      _buildRadioTile(
                        'Medium',
                        '₹50,001 - ₹1,00,000',
                        filters.tuitionFeeRange == 'Medium',
                        () => ref
                            .read(collegeFiltersProvider.notifier)
                            .setTuitionFeeRange('Medium'),
                      ),
                      _buildRadioTile(
                        'High',
                        '> ₹1,00,000',
                        filters.tuitionFeeRange == 'High',
                        () => ref
                            .read(collegeFiltersProvider.notifier)
                            .setTuitionFeeRange('High'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Cutoff Rank Range
                  _buildSectionTitle(Icons.star, 'Cutoff Rank Range'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Min Rank',
                            hintText: '1000',
                            filled: true,
                            fillColor: const Color(0xFFF9FAFB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            final minRank = int.tryParse(value);
                            ref
                                .read(collegeFiltersProvider.notifier)
                                .setCutoffRange(minRank, filters.maxCutoffRank);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Max Rank',
                            hintText: '5000',
                            filled: true,
                            fillColor: const Color(0xFFF9FAFB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            final maxRank = int.tryParse(value);
                            ref
                                .read(collegeFiltersProvider.notifier)
                                .setCutoffRange(filters.minCutoffRank, maxRank);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Actions
          Container(
            padding: const EdgeInsets.all(16),
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
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(collegeFiltersProvider.notifier).resetFilters();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF6366F1)),
                      foregroundColor: const Color(0xFF6366F1),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Reset All',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
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

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF6366F1)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6366F1) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxTile(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6366F1) : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioTile(
    String title,
    String subtitle,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6366F1).withAlpha(25)
              : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
