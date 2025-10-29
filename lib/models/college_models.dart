class CollegeBasic {
  final String id;
  final String name;
  final String location;
  final String type;
  final String imageUrl;

  const CollegeBasic({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.imageUrl,
  });

  factory CollegeBasic.fromJson(Map<String, dynamic> json) {
    return CollegeBasic(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      type: json['type'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}

class PredictedCollege {
  final String id;
  final String name;
  final String location;
  final String branch;
  final int cutoffRank;
  final int cutoffScore;
  final double probability;
  final String category;
  final String imageUrl;
  final String type;

  const PredictedCollege({
    required this.id,
    required this.name,
    required this.location,
    required this.branch,
    required this.cutoffRank,
    required this.cutoffScore,
    required this.probability,
    required this.category,
    required this.imageUrl,
    required this.type,
  });

  factory PredictedCollege.fromJson(Map<String, dynamic> json) {
    return PredictedCollege(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      branch: json['branch'] as String,
      cutoffRank: json['cutoffRank'] as int,
      cutoffScore: json['cutoffScore'] as int,
      probability: (json['probability'] as num).toDouble(),
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      type: json['type'] as String,
    );
  }
}

class CollegeDetail {
  final String id;
  final String name;
  final String location;
  final String type;
  final String accreditation;
  final String imageUrl;
  final String description;
  final int establishedYear;
  final String affiliatedTo;
  final String nirf;
  final List<String> coursesOffered;
  final Map<String, CutoffInfo> cutoffData;
  final FeeStructure feeStructure;
  final PlacementStats placementStats;
  final List<String> facilities;
  final double campusRating;
  final ContactInfo contactInfo;
  final List<String> galleryImages;

  const CollegeDetail({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.accreditation,
    required this.imageUrl,
    required this.description,
    required this.establishedYear,
    required this.affiliatedTo,
    required this.nirf,
    required this.coursesOffered,
    required this.cutoffData,
    required this.feeStructure,
    required this.placementStats,
    required this.facilities,
    required this.campusRating,
    required this.contactInfo,
    required this.galleryImages,
  });
}

class CutoffInfo {
  final int rank;
  final int score;

  const CutoffInfo({required this.rank, required this.score});
}

class FeeStructure {
  final int annualFees;
  final String year;

  const FeeStructure({required this.annualFees, required this.year});
}

class PlacementStats {
  final String avgPackage;
  final String year;

  const PlacementStats({required this.avgPackage, required this.year});
}

class ContactInfo {
  final String phone;
  final String email;
  final String website;

  const ContactInfo({
    required this.phone,
    required this.email,
    required this.website,
  });
}

class PredictionInput {
  final int mhcetScore;
  final int rank;
  final String category;
  final List<String> branchPreferences;
  final List<String> locationPreferences;
  final String quota;

  const PredictionInput({
    required this.mhcetScore,
    required this.rank,
    required this.category,
    required this.branchPreferences,
    required this.locationPreferences,
    required this.quota,
  });

  Map<String, dynamic> toJson() {
    return {
      'mhcetScore': mhcetScore,
      'rank': rank,
      'category': category,
      'branchPreferences': branchPreferences,
      'locationPreferences': locationPreferences,
      'quota': quota,
    };
  }
}
