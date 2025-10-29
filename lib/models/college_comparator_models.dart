// models/college_comparator_models.dart

class CollegeDetail {
  final String id;
  final String name;
  final String location;
  final String city;
  final String state;
  final List<String> branches;
  final String category; // 'General', 'General'
  final String accreditation; // 'NAAC A++', 'NAAC A++'
  final String annualFees;
  final String cutoffRank;
  final String avgPackage;
  final String facilities; // 'Hostel, Wi-Fi, Labs'
  final double campusRating;
  final String collegeType; // 'Government', 'Private', 'Autonomous', 'Minority'
  final String tuitionFeeRange;
  final String imageUrl;
  final List<String> tags;

  CollegeDetail({
    required this.id,
    required this.name,
    required this.location,
    required this.city,
    required this.state,
    required this.branches,
    required this.category,
    required this.accreditation,
    required this.annualFees,
    required this.cutoffRank,
    required this.avgPackage,
    required this.facilities,
    required this.campusRating,
    required this.collegeType,
    required this.tuitionFeeRange,
    required this.imageUrl,
    required this.tags,
  });
}

class ComparisonData {
  final List<CollegeDetail> colleges;
  final DateTime comparedAt;

  ComparisonData({required this.colleges, required this.comparedAt});
}

class CollegeFilters {
  final List<String> selectedBranches;
  final List<String> selectedRegions;
  final List<String> selectedCollegeTypes;
  final String tuitionFeeRange; // 'Low', 'Medium', 'High'
  final int? minCutoffRank;
  final int? maxCutoffRank;

  CollegeFilters({
    this.selectedBranches = const [],
    this.selectedRegions = const [],
    this.selectedCollegeTypes = const [],
    this.tuitionFeeRange = 'Medium',
    this.minCutoffRank,
    this.maxCutoffRank,
  });

  CollegeFilters copyWith({
    List<String>? selectedBranches,
    List<String>? selectedRegions,
    List<String>? selectedCollegeTypes,
    String? tuitionFeeRange,
    int? minCutoffRank,
    int? maxCutoffRank,
  }) {
    return CollegeFilters(
      selectedBranches: selectedBranches ?? this.selectedBranches,
      selectedRegions: selectedRegions ?? this.selectedRegions,
      selectedCollegeTypes: selectedCollegeTypes ?? this.selectedCollegeTypes,
      tuitionFeeRange: tuitionFeeRange ?? this.tuitionFeeRange,
      minCutoffRank: minCutoffRank ?? this.minCutoffRank,
      maxCutoffRank: maxCutoffRank ?? this.maxCutoffRank,
    );
  }
}
