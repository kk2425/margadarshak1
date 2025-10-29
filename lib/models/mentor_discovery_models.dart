// models/mentor_discovery_models.dart

class MentorCard {
  final String id;
  final String name;
  final String headline; // e.g., "3 Year at IIT Bombay"
  final String institution;
  final double rating;
  final String imageUrl;
  final List<String> expertise; // e.g., ["Design", "AI/ML", "Technology"]
  final AvailabilityStatus availability;
  final String? responseTime; // e.g., "Usually replies in 2 hours"
  final int totalSessions;
  final int studentsHelped;
  final bool isFavorite;

  MentorCard({
    required this.id,
    required this.name,
    required this.headline,
    required this.institution,
    required this.rating,
    required this.imageUrl,
    required this.expertise,
    required this.availability,
    this.responseTime,
    required this.totalSessions,
    required this.studentsHelped,
    this.isFavorite = false,
  });

  MentorCard copyWith({
    String? id,
    String? name,
    String? headline,
    String? institution,
    double? rating,
    String? imageUrl,
    List<String>? expertise,
    AvailabilityStatus? availability,
    String? responseTime,
    int? totalSessions,
    int? studentsHelped,
    bool? isFavorite,
  }) {
    return MentorCard(
      id: id ?? this.id,
      name: name ?? this.name,
      headline: headline ?? this.headline,
      institution: institution ?? this.institution,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      expertise: expertise ?? this.expertise,
      availability: availability ?? this.availability,
      responseTime: responseTime ?? this.responseTime,
      totalSessions: totalSessions ?? this.totalSessions,
      studentsHelped: studentsHelped ?? this.studentsHelped,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class AvailabilityStatus {
  final bool isAvailable;
  final String label; // "Available Today" / "Not Available" / "Booked Solid"

  AvailabilityStatus({required this.isAvailable, required this.label});
}

class MentorProfileDetail {
  final MentorCard basicInfo;
  final String bio;
  final List<String> domains;
  final List<String> skills;
  final String college;
  final String year;
  final Map<String, dynamic> stats; // Dynamic stats
  final List<MentorReview> reviews;
  final bool isCurrentlyAcceptingQuestions;
  final String? linkedInUrl;
  final String? portfolioUrl;

  MentorProfileDetail({
    required this.basicInfo,
    required this.bio,
    required this.domains,
    required this.skills,
    required this.college,
    required this.year,
    required this.stats,
    required this.reviews,
    required this.isCurrentlyAcceptingQuestions,
    this.linkedInUrl,
    this.portfolioUrl,
  });
}

class MentorReview {
  final String studentName;
  final double rating;
  final String review;
  final String timestamp;

  MentorReview({
    required this.studentName,
    required this.rating,
    required this.review,
    required this.timestamp,
  });
}

class MentorFilters {
  final List<String> selectedExpertise;
  final List<String> selectedColleges;
  final bool onlyAvailable;
  final double? minRating;

  MentorFilters({
    this.selectedExpertise = const [],
    this.selectedColleges = const [],
    this.onlyAvailable = false,
    this.minRating,
  });

  MentorFilters copyWith({
    List<String>? selectedExpertise,
    List<String>? selectedColleges,
    bool? onlyAvailable,
    double? minRating,
  }) {
    return MentorFilters(
      selectedExpertise: selectedExpertise ?? this.selectedExpertise,
      selectedColleges: selectedColleges ?? this.selectedColleges,
      onlyAvailable: onlyAvailable ?? this.onlyAvailable,
      minRating: minRating ?? this.minRating,
    );
  }
}

class AskMentorRequest {
  final String mentorId;
  final String question;
  final List<String> tags;
  final String studentId;
  final DateTime timestamp;

  AskMentorRequest({
    required this.mentorId,
    required this.question,
    required this.tags,
    required this.studentId,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'mentorId': mentorId,
      'question': question,
      'tags': tags,
      'studentId': studentId,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
