// screens/mentor_discovery/find_mentor_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/mentor_discovery_provider.dart';
import '../../models/mentor_discovery_models.dart';
import 'mentor_profile_screen.dart';

class FindMentorScreen extends ConsumerStatefulWidget {
  const FindMentorScreen({super.key});

  @override
  ConsumerState<FindMentorScreen> createState() => _FindMentorScreenState();
}

class _FindMentorScreenState extends ConsumerState<FindMentorScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMentors = ref.watch(filteredMentorsProvider);
    final availableExpertise = ref.watch(availableExpertiseProvider);
    final filters = ref.watch(mentorFiltersProvider);
    
    // Apply search filter dynamically
    final searchedMentors = _searchQuery.isEmpty
        ? filteredMentors
        : filteredMentors.where((mentor) {
            return mentor.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                mentor.institution.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                mentor.expertise.any((exp) => exp.toLowerCase().contains(_searchQuery.toLowerCase()));
          }).toList();

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              const Text(
                'Find a Mentor',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
        ),
        
        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search by college name or location...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              filled: true,
              fillColor: const Color(0xFFF3F4F6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Dynamic Filter Chips
        SizedBox(
          height: 40,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            children: [
              _buildFilterButton(context),
              const SizedBox(width: 8),
              // Dynamically generate expertise chips
              ...availableExpertise.take(5).map((expertise) {
                final isSelected = filters.selectedExpertise.contains(expertise);
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _buildChip(
                    expertise,
                    isSelected,
                    () => ref.read(mentorFiltersProvider.notifier).toggleExpertise(expertise),
                  ),
                );
              }),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Results Count (Dynamic)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${searchedMentors.length} mentors available',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  _showSortOptions(context);
                },
                icon: Icon(Icons.sort, size: 18, color: Colors.grey[700]),
                label: Text(
                  'Sort by',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
        
        // Mentor Cards (Dynamic)
        Expanded(
          child: searchedMentors.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: searchedMentors.length,
                  itemBuilder: (context, index) {
                    return _buildMentorCard(searchedMentors[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    final filters = ref.watch(mentorFiltersProvider);
    final activeFiltersCount = filters.selectedExpertise.length +
        filters.selectedColleges.length +
        (filters.onlyAvailable ? 1 : 0) +
        (filters.minRating != null ? 1 : 0);

    return GestureDetector(
      onTap: () {
        _showFilterBottomSheet(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: activeFiltersCount > 0 ? const Color(0xFF6366F1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: activeFiltersCount > 0 ? const Color(0xFF6366F1) : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.filter_list,
              size: 16,
              color: activeFiltersCount > 0 ? Colors.white : const Color(0xFF6366F1),
            ),
            const SizedBox(width: 4),
            Text(
              'Filters${activeFiltersCount > 0 ? " ($activeFiltersCount)" : ""}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: activeFiltersCount > 0 ? Colors.white : const Color(0xFF6366F1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6366F1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildMentorCard(MentorCard mentor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(body: MentorProfileScreen(mentorId: mentor.id)),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(12),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(mentor.imageUrl),
                ),
                const SizedBox(width: 12),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              mentor.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Color(0xFFF59E0B)),
                              const SizedBox(width: 4),
                              Text(
                                mentor.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        mentor.headline,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Dynamic Expertise Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: mentor.expertise.map((exp) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getExpertiseColor(exp).withAlpha(25),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    exp,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _getExpertiseColor(exp),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            
            // Availability and Actions
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: mentor.availability.isAvailable
                        ? const Color(0xFF10B981)
                        : Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  mentor.availability.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: mentor.availability.isAvailable
                        ? const Color(0xFF10B981)
                        : Colors.grey[600],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: mentor.availability.isAvailable
                      ? () {
                          // Navigate to Ask Mentor screen
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Connect',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text(
              'No mentors found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters or search terms',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getExpertiseColor(String expertise) {
    // Dynamic color assignment based on expertise
    final colorMap = {
      'Design': const Color(0xFF6366F1),
      'AI/ML': const Color(0xFF10B981),
      'Technology': const Color(0xFFEC4899),
      'Finance': const Color(0xFFF59E0B),
      'Strategy': const Color(0xFF8B5CF6),
      'Internships': const Color(0xFF06B6D4),
      'Research': const Color(0xFFF43F5E),
      'Engineering': const Color(0xFF14B8A6),
    };
    return colorMap[expertise] ?? const Color(0xFF6B7280);
  }

  void _showFilterBottomSheet(BuildContext context) {
    // Filter bottom sheet implementation
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: const Center(child: Text('Filter Options')),
        );
      },
    );
  }

  void _showSortOptions(BuildContext context) {
    // Sort options implementation
  }
}