// providers/college_comparator_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/college_comparator_models.dart';

// Sample college data
final collegesDataProvider = Provider<List<CollegeDetail>>((ref) {
  return [
    CollegeDetail(
      id: '1',
      name: 'IIT Bombay',
      location: 'Mumbai, Maharashtra',
      city: 'Mumbai',
      state: 'Maharashtra',
      branches: ['CSE', 'IT', 'ENTC'],
      category: 'General',
      accreditation: 'NAAC A++',
      annualFees: '₹2.5L',
      cutoffRank: '1-100',
      avgPackage: '₹16.8L',
      facilities: 'Hostel, Wi-Fi, Labs',
      campusRating: 4.6,
      collegeType: 'Government',
      tuitionFeeRange: '1-100',
      imageUrl: 'https://placehold.co/100x80/6366F1/FFFFFF?text=IIT',
      tags: ['CSE', 'IT', 'ENTC', '+6 more'],
    ),
    CollegeDetail(
      id: '2',
      name: 'VJTI Mumbai',
      location: 'Mumbai, Maharashtra',
      city: 'Mumbai',
      state: 'Maharashtra',
      branches: ['CSE', 'IT', 'Mech'],
      category: 'General',
      accreditation: 'NAAC A++',
      annualFees: '₹1L',
      cutoffRank: '500-2000',
      avgPackage: '₹12.8L',
      facilities: 'Hostel, Wi-Fi, Labs',
      campusRating: 4.8,
      collegeType: 'Government',
      tuitionFeeRange: 'Low',
      imageUrl: 'https://placehold.co/100x80/10B981/FFFFFF?text=VJTI',
      tags: ['CSE', 'IT', 'Mech', '+3 more'],
    ),
    CollegeDetail(
      id: '3',
      name: 'COEP Pune',
      location: 'Pune, Maharashtra',
      city: 'Pune',
      state: 'Maharashtra',
      branches: ['CSE', 'ENTC', 'Mech'],
      category: 'General',
      accreditation: 'NAAC A++',
      annualFees: '₹1.5L',
      cutoffRank: '800-3000',
      avgPackage: '₹10.5L',
      facilities: 'Hostel, Wi-Fi, Labs',
      campusRating: 4.5,
      collegeType: 'Autonomous',
      tuitionFeeRange: 'Medium',
      imageUrl: 'https://placehold.co/100x80/EC4899/FFFFFF?text=COEP',
      tags: ['CSE', 'ENTC', 'Mech', '+4 more'],
    ),
    CollegeDetail(
      id: '4',
      name: 'MIT Manipal',
      location: 'Manipal, Karnataka',
      city: 'Manipal',
      state: 'Karnataka',
      branches: ['CSE', 'IT', 'ENTC'],
      category: 'General',
      accreditation: 'NAAC A++',
      annualFees: '₹3L',
      cutoffRank: '5000-15000',
      avgPackage: '₹8.2L',
      facilities: 'Hostel, Wi-Fi, Labs',
      campusRating: 4.4,
      collegeType: 'Private',
      tuitionFeeRange: 'High',
      imageUrl: 'https://placehold.co/100x80/F59E0B/FFFFFF?text=MIT',
      tags: ['CSE', 'IT', 'ENTC', '+6 more'],
    ),
  ];
});

// Selected colleges for comparison (max 3)
final selectedCollegesProvider = StateNotifierProvider<SelectedCollegesNotifier, List<CollegeDetail>>((ref) {
  return SelectedCollegesNotifier();
});

class SelectedCollegesNotifier extends StateNotifier<List<CollegeDetail>> {
  SelectedCollegesNotifier() : super([]);

  void addCollege(CollegeDetail college) {
    if (state.length < 3 && !state.any((c) => c.id == college.id)) {
      state = [...state, college];
    }
  }

  void removeCollege(String collegeId) {
    state = state.where((c) => c.id != collegeId).toList();
  }

  void clearAll() {
    state = [];
  }

  void replaceCollege(int index, CollegeDetail college) {
    if (index < state.length) {
      final newList = List<CollegeDetail>.from(state);
      newList[index] = college;
      state = newList;
    }
  }
}

// Filters provider
final collegeFiltersProvider = StateNotifierProvider<CollegeFiltersNotifier, CollegeFilters>((ref) {
  return CollegeFiltersNotifier();
});

class CollegeFiltersNotifier extends StateNotifier<CollegeFilters> {
  CollegeFiltersNotifier() : super(CollegeFilters());

  void toggleBranch(String branch) {
    final branches = List<String>.from(state.selectedBranches);
    if (branches.contains(branch)) {
      branches.remove(branch);
    } else {
      branches.add(branch);
    }
    state = state.copyWith(selectedBranches: branches);
  }

  void toggleRegion(String region) {
    final regions = List<String>.from(state.selectedRegions);
    if (regions.contains(region)) {
      regions.remove(region);
    } else {
      regions.add(region);
    }
    state = state.copyWith(selectedRegions: regions);
  }

  void toggleCollegeType(String type) {
    final types = List<String>.from(state.selectedCollegeTypes);
    if (types.contains(type)) {
      types.remove(type);
    } else {
      types.add(type);
    }
    state = state.copyWith(selectedCollegeTypes: types);
  }

  void setTuitionFeeRange(String range) {
    state = state.copyWith(tuitionFeeRange: range);
  }

  void setCutoffRange(int? min, int? max) {
    state = state.copyWith(minCutoffRank: min, maxCutoffRank: max);
  }

  void resetFilters() {
    state = CollegeFilters();
  }
}

// Filtered colleges provider
final filteredCollegesProvider = Provider<List<CollegeDetail>>((ref) {
  final colleges = ref.watch(collegesDataProvider);
  final filters = ref.watch(collegeFiltersProvider);

  return colleges.where((college) {
    // Branch filter
    if (filters.selectedBranches.isNotEmpty) {
      bool hasMatchingBranch = filters.selectedBranches.any(
        (branch) => college.branches.contains(branch),
      );
      if (!hasMatchingBranch) return false;
    }

    // Region filter
    if (filters.selectedRegions.isNotEmpty) {
      if (!filters.selectedRegions.contains(college.state)) return false;
    }

    // College type filter
    if (filters.selectedCollegeTypes.isNotEmpty) {
      if (!filters.selectedCollegeTypes.contains(college.collegeType)) return false;
    }

    // Tuition fee range filter
    if (filters.tuitionFeeRange == 'Low' && college.tuitionFeeRange != 'Low') {
      return false;
    }
    if (filters.tuitionFeeRange == 'High' && college.tuitionFeeRange != 'High') {
      return false;
    }

    return true;
  }).toList();
});