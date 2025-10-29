import 'dart:async';
import '../models/college_models.dart';

class CollegeService {
  // Placeholder for Python FastAPI backend integration
  Future<List<PredictedCollege>> fetchPrediction(
    PredictionInput inputData,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Replace with actual API call to Python backend
    // Example:
    // final response = await http.post(
    //   Uri.parse('https://your-api.com/predict'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(inputData.toJson()),
    // );
    // return (jsonDecode(response.body) as List)
    //     .map((e) => PredictedCollege.fromJson(e))
    //     .toList();

    // Mock data for now
    return _getMockPredictions(inputData);
  }

  Future<CollegeDetail> fetchCollegeDetail(String collegeId) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // TODO: Replace with actual API call
    // final response = await http.get(
    //   Uri.parse('https://your-api.com/colleges/$collegeId'),
    // );
    // return CollegeDetail.fromJson(jsonDecode(response.body));

    return _getMockCollegeDetail(collegeId);
  }

  // Mock data generation
  List<PredictedCollege> _getMockPredictions(PredictionInput input) {
    return [
      PredictedCollege(
        id: '1',
        name: 'Veermata Jijabai Technological Institute',
        location: 'Mumbai, Maharashtra',
        branch: input.branchPreferences.isNotEmpty
            ? input.branchPreferences[0]
            : 'Computer Engineering',
        cutoffRank: 4254,
        cutoffScore: 180,
        probability: 95.5,
        category: 'Government',
        imageUrl: 'https://placehold.co/400x300/E8EAF6/3F51B5?text=VJTI',
        type: 'High Chance',
      ),
      PredictedCollege(
        id: '2',
        name: 'College of Engineering Pune',
        location: 'Pune, Maharashtra',
        branch: input.branchPreferences.isNotEmpty
            ? input.branchPreferences[0]
            : 'Computer Engineering',
        cutoffRank: 4430,
        cutoffScore: 178,
        probability: 88.0,
        category: 'Government',
        imageUrl: 'https://placehold.co/400x300/E8F5E9/2E7D32?text=COEP',
        type: 'High Chance',
      ),
      PredictedCollege(
        id: '3',
        name: 'Institute of Chemical Technology',
        location: 'Mumbai, Maharashtra',
        branch: 'Chemical Engineering',
        cutoffRank: 4680,
        cutoffScore: 175,
        probability: 75.5,
        category: 'Government',
        imageUrl: 'https://placehold.co/400x300/FFF3E0/E65100?text=ICT',
        type: 'Medium',
      ),
      PredictedCollege(
        id: '4',
        name: 'Walchand College of Engineering',
        location: 'Sangli, Maharashtra',
        branch: input.branchPreferences.isNotEmpty
            ? input.branchPreferences[0]
            : 'Computer Engineering',
        cutoffRank: 5120,
        cutoffScore: 170,
        probability: 65.0,
        category: 'Government',
        imageUrl: 'https://placehold.co/400x300/F3E5F5/6A1B9A?text=WCE',
        type: 'Medium',
      ),
      PredictedCollege(
        id: '5',
        name: 'Government College of Engineering',
        location: 'Aurangabad, Maharashtra',
        branch: input.branchPreferences.isNotEmpty
            ? input.branchPreferences[0]
            : 'Computer Engineering',
        cutoffRank: 6200,
        cutoffScore: 162,
        probability: 45.0,
        category: 'Government',
        imageUrl: 'https://placehold.co/400x300/E0F2F1/00695C?text=GECA',
        type: 'Low Chance',
      ),
    ];
  }

  CollegeDetail _getMockCollegeDetail(String collegeId) {
    return CollegeDetail(
      id: collegeId,
      name: 'MIT College of Engineering',
      location: 'Pune, Maharashtra',
      type: 'Autonomous',
      accreditation: 'NAAC A++',
      imageUrl: 'https://placehold.co/600x400/E8EAF6/3F51B5?text=MIT',
      description:
          'MIT College of Engineering is one of the premier engineering institutes in Maharashtra, known for its excellent academic programs and industry connections.',
      establishedYear: 1983,
      affiliatedTo: 'Savitribai Phule Pune University',
      nirf: 'Ranked 45th',
      coursesOffered: [
        'B.E Computer Engineering',
        'B.E Electronics Engineering',
        'B.E Mechanical Engineering',
        'B.E Civil Engineering',
      ],
      cutoffData: {
        'Computer Engineering': const CutoffInfo(rank: 4254, score: 180),
        'Electronics Engineering': const CutoffInfo(rank: 5680, score: 172),
      },
      feeStructure: const FeeStructure(annualFees: 185000, year: '2023'),
      placementStats: const PlacementStats(avgPackage: '8.5 LPA', year: '2023'),
      facilities: ['Library', 'Labs', 'Sports', 'Hostel', 'Canteen'],
      campusRating: 4.5,
      contactInfo: const ContactInfo(
        phone: '+91-20-2614-0000',
        email: 'info@mitcoe.edu',
        website: 'www.mitcoe.edu',
      ),
      galleryImages: [
        'https://placehold.co/400x300/E8EAF6/3F51B5?text=Campus1',
        'https://placehold.co/400x300/E8EAF6/3F51B5?text=Campus2',
        'https://placehold.co/400x300/E8EAF6/3F51B5?text=Campus3',
        'https://placehold.co/400x300/E8EAF6/3F51B5?text=Campus4',
      ],
    );
  }
}
