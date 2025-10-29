// providers/mentor_discovery_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mentor_discovery_models.dart';

// Mock data - replace with Firebase/API calls
final mentorsDataProvider = Provider<List<MentorCard>>((ref) {
  return [
    MentorCard(
      id: '1',
      name: 'Arjun Sharma',
      headline: '3 Year at IIT Bombay',
      institution: 'IIT Bombay',
      rating: 4.8,
      imageUrl: 'https://placehold.co/100x100/6366F1/FFFFFF?text=AS',
      expertise: ['Design', 'AI/ML', 'Technology'],
      availability: AvailabilityStatus(isAvailable: true, label: 'Available Today'),
      responseTime: 'Usually replies in 2 hours',
      totalSessions: 45,
      studentsHelped: 120,
    ),
    MentorCard(
      id: '2',
      name: 'Priya Patel',
      headline: '2nd Year at Internship @ Google',
      institution: 'Stanford University',
      rating: 4.9,
      imageUrl: 'https://placehold.co/100x100/10B981/FFFFFF?text=PP',
      expertise: ['Design', 'Internships'],
      availability: AvailabilityStatus(isAvailable: true, label: 'Available Today'),
      responseTime: 'Usually replies in 3 hours',
      totalSessions: 67,
      studentsHelped: 89,
    ),
    MentorCard(
      id: '3',
      name: 'Mihul Kotian',
      headline: '3rd Year at Internship @ Deloitte',
      institution: 'Mumbai University',
      rating: 5.0,
      imageUrl: 'https://placehold.co/100x100/EC4899/FFFFFF?text=MK',
      expertise: ['Finance', 'Strategy'],
      availability: AvailabilityStatus(isAvailable: false, label: 'Fully Booked'),
      responseTime: 'Usually replies in 1 day',
      totalSessions: 23,
      studentsHelped: 56,
    ),
    MentorCard(
      id: '4',
      name: 'Sneha Singh',
      headline: 'PhD at MIT | Mentored 1-5 Students',
      institution: 'MIT',
      rating: 4.7,
      imageUrl: 'https://placehold.co/100x100/F59E0B/FFFFFF?text=SS',
      expertise: ['Design', 'Research'],
      availability: AvailabilityStatus(isAvailable: true, label: 'Available Today'),
      responseTime: 'Usually replies in 4 hours',
      totalSessions: 34,
      studentsHelped: 78,
    ),
    MentorCard(
      id: '5',
      name: 'Vikash Gupta',
      headline: 'PhD at Berkeley | Mentored 1-5 Students',
      institution: 'UC Berkeley',
      rating: 4.9,
      imageUrl: 'https://placehold.co/100x100/8B5CF6/FFFFFF?text=VG',
      expertise: ['Engineering', 'Research'],
      availability: AvailabilityStatus(isAvailable: true, label: 'Available Today'),
      responseTime: 'Usually replies in 2 hours',
      totalSessions: 56,
      studentsHelped: 134,
    ),
  ];
});

// Favorite mentors provider
final favoriteMentorsProvider = StateNotifierProvider<FavoriteMentorsNotifier, Set<String>>((ref) {
  return FavoriteMentorsNotifier();
});

class FavoriteMentorsNotifier extends StateNotifier<Set<String>> {
  FavoriteMentorsNotifier() : super({});

  void toggleFavorite(String mentorId) {
    if (state.contains(mentorId)) {
      state = {...state}..remove(mentorId);
    } else {
      state = {...state, mentorId};
    }
  }

  bool isFavorite(String mentorId) {
    return state.contains(mentorId);
  }
}

// Mentor filters provider
final mentorFiltersProvider = StateNotifierProvider<MentorFiltersNotifier, MentorFilters>((ref) {
  return MentorFiltersNotifier();
});

class MentorFiltersNotifier extends StateNotifier<MentorFilters> {
  MentorFiltersNotifier() : super(MentorFilters());

  void toggleExpertise(String expertise) {
    final current = List<String>.from(state.selectedExpertise);
    if (current.contains(expertise)) {
      current.remove(expertise);
    } else {
      current.add(expertise);
    }
    state = state.copyWith(selectedExpertise: current);
  }

  void toggleCollege(String college) {
    final current = List<String>.from(state.selectedColleges);
    if (current.contains(college)) {
      current.remove(college);
    } else {
      current.add(college);
    }
    state = state.copyWith(selectedColleges: current);
  }

  void setOnlyAvailable(bool value) {
    state = state.copyWith(onlyAvailable: value);
  }

  void setMinRating(double? rating) {
    state = state.copyWith(minRating: rating);
  }

  void resetFilters() {
    state = MentorFilters();
  }
}

// Filtered mentors provider (dynamic)
final filteredMentorsProvider = Provider<List<MentorCard>>((ref) {
  final mentors = ref.watch(mentorsDataProvider);
  final filters = ref.watch(mentorFiltersProvider);
  final favorites = ref.watch(favoriteMentorsProvider);

  return mentors.where((mentor) {
    // Filter by expertise
    if (filters.selectedExpertise.isNotEmpty) {
      final hasMatchingExpertise = mentor.expertise.any(
        (exp) => filters.selectedExpertise.contains(exp),
      );
      if (!hasMatchingExpertise) return false;
    }

    // Filter by availability
    if (filters.onlyAvailable && !mentor.availability.isAvailable) {
      return false;
    }

    // Filter by rating
    if (filters.minRating != null && mentor.rating < filters.minRating!) {
      return false;
    }

    // Filter by college
    if (filters.selectedColleges.isNotEmpty) {
      if (!filters.selectedColleges.contains(mentor.institution)) {
        return false;
      }
    }

    return true;
  }).map((mentor) {
    // Add favorite status dynamically
    return mentor.copyWith(isFavorite: favorites.contains(mentor.id));
  }).toList();
});

// Available expertise tags (dynamic - extracted from all mentors)
final availableExpertiseProvider = Provider<List<String>>((ref) {
  final mentors = ref.watch(mentorsDataProvider);
  final expertiseSet = <String>{};
  
  for (var mentor in mentors) {
    expertiseSet.addAll(mentor.expertise);
  }
  
  return expertiseSet.toList()..sort();
});

// Available colleges (dynamic - extracted from all mentors)
final availableCollegesProvider = Provider<List<String>>((ref) {
  final mentors = ref.watch(mentorsDataProvider);
  final collegeSet = <String>{};
  
  for (var mentor in mentors) {
    collegeSet.add(mentor.institution);
  }
  
  return collegeSet.toList()..sort();
});