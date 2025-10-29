// lib/screens/college_predictor/predictor_home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/constants.dart';
import 'input_form_screen.dart';
import '../../models/college_models.dart';
import 'college_detail_screen.dart';

class PredictorHomeScreen extends ConsumerWidget {
  const PredictorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dummy data for featured colleges
    final List<PredictedCollege> featuredColleges = [
      // Add dummy predicted college data here
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Sliver App Bar
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(context),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: _buildSearchBar(),
            ),
          ),

          // Body content
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildSectionHeader(context, 'Featured Colleges'),
                _buildFeaturedColleges(featuredColleges),
                _buildSectionHeader(context, 'Explore by Branch'),
                _buildBranchGrid(context),
                const SizedBox(height: 24),
                _buildSectionHeader(context, 'Top Ranked Colleges'),
                _buildTopRankedColleges(featuredColleges),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InputFormScreen()),
          );
        },
        label: const Text('Predict My College'),
        icon: const Icon(Icons.psychology),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Find Your Dream College',
            style: AppTextStyles.headingLarge.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Based on your MH-CET score, rank, and preferences',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for a college...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.backgroundLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.headingSmall),
          TextButton(
            onPressed: () {},
            child: const Text(
              'See All',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedColleges(List<PredictedCollege> colleges) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: colleges.length,
        itemBuilder: (context, index) {
          return _buildCollegeCard(context, colleges[index], true);
        },
      ),
    );
  }

  Widget _buildTopRankedColleges(List<PredictedCollege> colleges) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: colleges.length,
      itemBuilder: (context, index) {
        return _buildCollegeCard(context, colleges[index], false);
      },
    );
  }

  Widget _buildCollegeCard(
      BuildContext context, PredictedCollege college, bool isFeatured) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CollegeDetailScreen(collegeId: college.id),
          ),
        );
      },
      child: Container(
        width: isFeatured ? 280 : null,
        margin: EdgeInsets.only(right: isFeatured ? 16 : 0, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                college.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    college.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          college.location,
                          style: AppTextStyles.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoChip(college.branch),
                      const SizedBox(width: 8),
                      _buildInfoChip(college.type),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildBranchGrid(BuildContext context) {
    final branches = [
      {'name': 'Computer', 'icon': Icons.computer, 'color': AppColors.primary},
      {'name': 'IT', 'icon': Icons.code, 'color': AppColors.accent},
      {'name': 'AI & DS', 'icon': Icons.psychology, 'color': AppColors.secondary},
      {'name': 'ENTC', 'icon': Icons.electrical_services, 'color': AppColors.warning},
      {'name': 'Mechanical', 'icon': Icons.settings, 'color': Colors.blueGrey},
      {'name': 'Civil', 'icon': Icons.home_work, 'color': Colors.brown},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: branches.length,
      itemBuilder: (context, index) {
        final branch = branches[index];
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                (branch['color'] as Color).withAlpha((255 * 0.8).round()),
                (branch['color'] as Color),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(branch['icon'] as IconData, color: Colors.white, size: 28),
              const SizedBox(height: 8),
              Text(
                branch['name'] as String,
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
