// providers/assessment_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question_models.dart';
import '../data/questions_data.dart';

class AssessmentState {
  final int currentQuestionIndex;
  final List<AssessmentAnswer> aptitudeAnswers;
  final List<InterestAnswer> interestAnswers;
  final AptitudeScores? aptitudeScores;
  final InterestScores? interestScores;
  final bool isAptitudeComplete;
  final bool isInterestComplete;
  final AIPersonalizationAnswers? aiAnswers;

  AssessmentState({
    this.currentQuestionIndex = 0,
    this.aptitudeAnswers = const [],
    this.interestAnswers = const [],
    this.aptitudeScores,
    this.interestScores,
    this.isAptitudeComplete = false,
    this.isInterestComplete = false,
    this.aiAnswers,
  });

  AssessmentState copyWith({
    int? currentQuestionIndex,
    List<AssessmentAnswer>? aptitudeAnswers,
    List<InterestAnswer>? interestAnswers,
    AptitudeScores? aptitudeScores,
    InterestScores? interestScores,
    bool? isAptitudeComplete,
    bool? isInterestComplete,
    AIPersonalizationAnswers? aiAnswers,
  }) {
    return AssessmentState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      aptitudeAnswers: aptitudeAnswers ?? this.aptitudeAnswers,
      interestAnswers: interestAnswers ?? this.interestAnswers,
      aptitudeScores: aptitudeScores ?? this.aptitudeScores,
      interestScores: interestScores ?? this.interestScores,
      isAptitudeComplete: isAptitudeComplete ?? this.isAptitudeComplete,
      isInterestComplete: isInterestComplete ?? this.isInterestComplete,
      aiAnswers: aiAnswers ?? this.aiAnswers,
    );
  }
}

class AssessmentNotifier extends StateNotifier<AssessmentState> {
  AssessmentNotifier() : super(AssessmentState());

  void answerAptitudeQuestion(int questionId, int selectedOption) {
    final question = QuestionsData.aptitudeQuestions.firstWhere(
      (q) => q.id == questionId,
    );
    final isCorrect = selectedOption == question.correctAnswer;

    final newAnswer = AssessmentAnswer(
      questionId: questionId,
      selectedOption: selectedOption,
      isCorrect: isCorrect,
    );

    final updatedAnswers = [...state.aptitudeAnswers, newAnswer];

    state = state.copyWith(
      aptitudeAnswers: updatedAnswers,
      currentQuestionIndex: state.currentQuestionIndex + 1,
    );

    // Check if aptitude test is complete
    if (updatedAnswers.length == QuestionsData.aptitudeQuestions.length) {
      _calculateAptitudeScores();
      state = state.copyWith(isAptitudeComplete: true);
    }
  }

  void answerInterestQuestion(int questionId, int rating) {
    final newAnswer = InterestAnswer(questionId: questionId, rating: rating);

    final updatedAnswers = [...state.interestAnswers, newAnswer];

    state = state.copyWith(
      interestAnswers: updatedAnswers,
      currentQuestionIndex: state.currentQuestionIndex + 1,
    );

    // Check if interest test is complete
    if (updatedAnswers.length == QuestionsData.interestQuestions.length) {
      _calculateInterestScores();
      state = state.copyWith(isInterestComplete: true);
    }
  }

  void setAIAnswers(String answer1, String answer2, String answer3) {
    state = state.copyWith(
      aiAnswers: AIPersonalizationAnswers(
        question1Answer: answer1,
        question2Answer: answer2,
        question3Answer: answer3,
      ),
    );
  }

  void _calculateAptitudeScores() {
    final answers = state.aptitudeAnswers;

    // Calculate scores for each category
    double verbalScore = _calculateCategoryScore('verbal', answers);
    double logicalScore = _calculateCategoryScore('logical', answers);
    double spatialScore = _calculateCategoryScore('spatial', answers);
    double numericalScore = _calculateCategoryScore('numerical', answers);

    state = state.copyWith(
      aptitudeScores: AptitudeScores(
        verbal: verbalScore,
        logical: logicalScore,
        spatial: spatialScore,
        numerical: numericalScore,
      ),
    );
  }

  double _calculateCategoryScore(
    String category,
    List<AssessmentAnswer> answers,
  ) {
    final categoryQuestions = QuestionsData.aptitudeQuestions
        .where((q) => q.category == category)
        .toList();

    if (categoryQuestions.isEmpty) return 0.0;

    int correctCount = 0;
    for (var question in categoryQuestions) {
      final answer = answers.firstWhere(
        (a) => a.questionId == question.id,
        orElse: () =>
            AssessmentAnswer(questionId: question.id, selectedOption: -1),
      );
      if (answer.isCorrect) correctCount++;
    }

    return correctCount / categoryQuestions.length;
  }

  void _calculateInterestScores() {
    final answers = state.interestAnswers;

    // Calculate average rating for each RIASEC category
    double realisticScore = _calculateInterestCategoryScore(
      'realistic',
      answers,
    );
    double investigativeScore = _calculateInterestCategoryScore(
      'investigative',
      answers,
    );
    double artisticScore = _calculateInterestCategoryScore('artistic', answers);
    double socialScore = _calculateInterestCategoryScore('social', answers);
    double enterprisingScore = _calculateInterestCategoryScore(
      'enterprising',
      answers,
    );
    double conventionalScore = _calculateInterestCategoryScore(
      'conventional',
      answers,
    );

    state = state.copyWith(
      interestScores: InterestScores(
        realistic: realisticScore,
        investigative: investigativeScore,
        artistic: artisticScore,
        social: socialScore,
        enterprising: enterprisingScore,
        conventional: conventionalScore,
      ),
    );
  }

  double _calculateInterestCategoryScore(
    String category,
    List<InterestAnswer> answers,
  ) {
    final categoryQuestions = QuestionsData.interestQuestions
        .where((q) => q.category == category)
        .toList();

    if (categoryQuestions.isEmpty) return 0.0;

    int totalRating = 0;
    for (var question in categoryQuestions) {
      final answer = answers.firstWhere(
        (a) => a.questionId == question.id,
        orElse: () => InterestAnswer(questionId: question.id, rating: 0),
      );
      totalRating += answer.rating;
    }

    // Normalize to 0-1 scale (rating is 1-5, so divide by (5 * count))
    return totalRating / (5 * categoryQuestions.length);
  }

  void resetAssessment() {
    state = AssessmentState();
  }

  void startInterestTest() {
    state = state.copyWith(currentQuestionIndex: 0);
  }
}

final assessmentProvider =
    StateNotifierProvider<AssessmentNotifier, AssessmentState>((ref) {
      return AssessmentNotifier();
    });
