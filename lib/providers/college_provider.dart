import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/college_models.dart';
import '../services/college_service.dart';

final collegeServiceProvider = Provider<CollegeService>((ref) {
  return CollegeService();
});

final predictionInputProvider = StateProvider<PredictionInput?>((ref) => null);

final predictedCollegesProvider =
    FutureProvider.autoDispose<List<PredictedCollege>>((ref) async {
  final input = ref.watch(predictionInputProvider);
  if (input == null) {
    return [];
  }

  final service = ref.watch(collegeServiceProvider);
  return service.fetchPrediction(input);
});

final collegeDetailProvider =
    FutureProvider.family<CollegeDetail, String>((ref, collegeId) async {
  final service = ref.watch(collegeServiceProvider);
  return service.fetchCollegeDetail(collegeId);
});

// Form state providers
final mhcetScoreProvider = StateProvider<String>((ref) => '');
final rankProvider = StateProvider<String>((ref) => '');
final categoryProvider = StateProvider<String>((ref) => 'OPEN');
final quotaProvider = StateProvider<String>((ref) => 'All India');
final selectedBranchesProvider = StateProvider<List<String>>((ref) => []);
final selectedLocationsProvider = StateProvider<List<String>>((ref) => []);

// Validation provider
final formValidProvider = Provider<bool>((ref) {
  final score = ref.watch(mhcetScoreProvider);
  final rank = ref.watch(rankProvider);
  final branches = ref.watch(selectedBranchesProvider);

  return score.isNotEmpty &&
      int.tryParse(score) != null &&
      rank.isNotEmpty &&
      int.tryParse(rank) != null &&
      branches.isNotEmpty;
});
