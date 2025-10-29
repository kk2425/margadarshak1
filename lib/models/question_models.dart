// models/question_models.dart

class AptitudeQuestion {
  final int id;
  final String category;
  final String question;
  final List<String> options;
  final int correctAnswer;

  AptitudeQuestion({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class InterestQuestion {
  final int id;
  final String category;
  final String question;

  InterestQuestion({
    required this.id,
    required this.category,
    required this.question,
  });
}

class AssessmentAnswer {
  final int questionId;
  final int selectedOption;
  final bool isCorrect;

  AssessmentAnswer({
    required this.questionId,
    required this.selectedOption,
    this.isCorrect = false,
  });
}

class InterestAnswer {
  final int questionId;
  final int rating; // 1-5 scale

  InterestAnswer({required this.questionId, required this.rating});
}

class AptitudeScores {
  final double verbal;
  final double logical;
  final double spatial;
  final double numerical;

  AptitudeScores({
    required this.verbal,
    required this.logical,
    required this.spatial,
    required this.numerical,
  });

  Map<String, double> toMap() {
    return {
      'verbal': verbal,
      'logical': logical,
      'spatial': spatial,
      'numerical': numerical,
    };
  }
}

class InterestScores {
  final double realistic;
  final double investigative;
  final double artistic;
  final double social;
  final double enterprising;
  final double conventional;

  InterestScores({
    required this.realistic,
    required this.investigative,
    required this.artistic,
    required this.social,
    required this.enterprising,
    required this.conventional,
  });

  Map<String, double> toMap() {
    return {
      'realistic': realistic,
      'investigative': investigative,
      'artistic': artistic,
      'social': social,
      'enterprising': enterprising,
      'conventional': conventional,
    };
  }
}

class CareerRecommendation {
  final String title;
  final String description;
  final double matchScore;
  final List<String> skills;
  final List<String> interests;
  final String salaryRange;
  final String demand;

  CareerRecommendation({
    required this.title,
    required this.description,
    required this.matchScore,
    required this.skills,
    required this.interests,
    required this.salaryRange,
    required this.demand,
  });
}

class AIPersonalizationAnswers {
  final String question1Answer;
  final String question2Answer;
  final String question3Answer;

  AIPersonalizationAnswers({
    required this.question1Answer,
    required this.question2Answer,
    required this.question3Answer,
  });

  List<String> toList() {
    return [question1Answer, question2Answer, question3Answer];
  }
}
