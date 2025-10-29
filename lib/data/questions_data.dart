// data/questions_data.dart
import '../models/question_models.dart';

class QuestionsData {
  static final List<AptitudeQuestion> aptitudeQuestions = [
    // Verbal (6 questions)
    AptitudeQuestion(
      id: 1,
      category: 'verbal',
      question: 'Which word is a synonym for "ephemeral"?',
      options: ['Eternal', 'Transient', 'Powerful', 'Common'],
      correctAnswer: 1,
    ),
    AptitudeQuestion(
      id: 2,
      category: 'verbal',
      question: 'Complete the analogy: Tree is to Forest as Star is to...',
      options: ['Planet', 'Galaxy', 'Sun', 'Night'],
      correctAnswer: 1,
    ),
    AptitudeQuestion(
      id: 3,
      category: 'verbal',
      question:
          'Identify the error: "The team of players are celebrating their victory."',
      options: [
        'team of players',
        'are celebrating',
        'their victory',
        'No error',
      ],
      correctAnswer: 1,
    ),
    AptitudeQuestion(
      id: 4,
      category: 'verbal',
      question: 'What does the idiom "bite the bullet" mean?',
      options: [
        'To eat quickly',
        'To get injured',
        'To face a difficult situation with courage',
        'To make a mistake',
      ],
      correctAnswer: 2,
    ),
    AptitudeQuestion(
      id: 5,
      category: 'verbal',
      question: 'Which word does not belong? "Apple, Banana, Rose, Orange"',
      options: ['Apple', 'Banana', 'Rose', 'Orange'],
      correctAnswer: 2,
    ),
    AptitudeQuestion(
      id: 6,
      category: 'verbal',
      question: 'Which word is an antonym for "verbose"?',
      options: ['Talkative', 'Wordy', 'Succinct', 'Loud'],
      correctAnswer: 2,
    ),

    // Logical (6 questions)
    AptitudeQuestion(
      id: 7,
      category: 'logical',
      question: 'What number comes next in the sequence: 2, 5, 11, 23, ?',
      options: ['46', '47', '48', '49'],
      correctAnswer: 1,
    ),
    AptitudeQuestion(
      id: 8,
      category: 'logical',
      question:
          'If all Zips are Zaps and some Zaps are Zops, what can be concluded?',
      options: [
        'All Zips are Zops',
        'Some Zips are Zops',
        'No Zips are Zops',
        'Cannot be determined',
      ],
      correctAnswer: 3,
    ),
    AptitudeQuestion(
      id: 9,
      category: 'logical',
      question:
          'A is the father of B. B is the sister of C. How is A related to C?',
      options: ['Father', 'Uncle', 'Brother', 'Grandfather'],
      correctAnswer: 0,
    ),
    AptitudeQuestion(
      id: 10,
      category: 'logical',
      question:
          'If a plane crashes on the border of the USA and Canada, where do they bury the survivors?',
      options: ['USA', 'Canada', 'Nowhere', 'Depends on nationality'],
      correctAnswer: 2,
    ),
    AptitudeQuestion(
      id: 11,
      category: 'logical',
      question:
          'Which shape completes the pattern? (Assume a visual pattern: Square, Triangle, Circle, Square, ...)',
      options: ['Square', 'Circle', 'Triangle', 'Pentagon'],
      correctAnswer: 2,
    ),
    AptitudeQuestion(
      id: 12,
      category: 'logical',
      question: 'Cup is to Coffee as Bowl is to...',
      options: ['Plate', 'Soup', 'Spoon', 'Food'],
      correctAnswer: 1,
    ),

    // Spatial (6 questions)
    AptitudeQuestion(
      id: 13,
      category: 'spatial',
      question: 'If you rotate a "d" 180 degrees, it becomes a...',
      options: ['b', 'p', 'q', 'd'],
      correctAnswer: 1,
    ),
    AptitudeQuestion(
      id: 14,
      category: 'spatial',
      question: 'Which of the following shapes can be folded to form a cube?',
      options: [
        'A cross shape of 6 squares',
        'A straight line of 6 squares',
        'A T-shape with 5 squares',
        'A 2x3 grid of squares',
      ],
      correctAnswer: 0,
    ),
    AptitudeQuestion(
      id: 15,
      category: 'spatial',
      question: 'Imagine a 3D cube. How many faces does it have?',
      options: ['4', '6', '8', '12'],
      correctAnswer: 1,
    ),
    AptitudeQuestion(
      id: 16,
      category: 'spatial',
      question:
          'If you are facing North and turn right, then right again, then left, which direction are you facing?',
      options: ['North', 'East', 'South', 'West'],
      correctAnswer: 1,
    ),
    AptitudeQuestion(
      id: 17,
      category: 'spatial',
      question: 'Which of these is not a 3D shape?',
      options: ['Sphere', 'Pyramid', 'Triangle', 'Cylinder'],
      correctAnswer: 2,
    ),
    AptitudeQuestion(
      id: 18,
      category: 'spatial',
      question:
          'Which of the following 2D nets can be folded to form a pyramid?',
      options: [
        'A square with four triangles attached to its sides',
        'Six squares in a cross shape',
        'A circle with a sector removed',
        'Two hexagons and six rectangles',
      ],
      correctAnswer: 0,
    ),

    // Numerical (6 questions)
    AptitudeQuestion(
      id: 19,
      category: 'numerical',
      question: 'What is 15% of 200?',
      options: ['15', '20', '30', '40'],
      correctAnswer: 2,
    ),
    AptitudeQuestion(
      id: 20,
      category: 'numerical',
      question:
          'A car travels at 60 km/h. How far will it travel in 2.5 hours?',
      options: ['120 km', '150 km', '180 km', '100 km'],
      correctAnswer: 1,
    ),
    AptitudeQuestion(
      id: 21,
      category: 'numerical',
      question: 'If 3 apples cost \$2.10, how much do 7 apples cost?',
      options: ['\$4.20', '\$4.90', '\$5.60', '\$7.00'],
      correctAnswer: 1,
    ),
    AptitudeQuestion(
      id: 22,
      category: 'numerical',
      question: 'What is the next prime number after 13?',
      options: ['14', '15', '16', '17'],
      correctAnswer: 3,
    ),
    AptitudeQuestion(
      id: 23,
      category: 'numerical',
      question:
          'The average of three numbers is 10. If two numbers are 8 and 12, what is the third number?',
      options: ['10', '9', '11', '13'],
      correctAnswer: 0,
    ),
    AptitudeQuestion(
      id: 24,
      category: 'numerical',
      question:
          "A jacket is priced at \$120. It's on sale for 25% off. What is the final price?",
      options: ['\$90', '\$95', '\$100', '\$85'],
      correctAnswer: 0,
    ),
  ];

  static final List<InterestQuestion> interestQuestions = [
    // Realistic (4 questions)
    InterestQuestion(
      id: 1,
      category: 'realistic',
      question:
          'I enjoy hands-on activities like building models, fixing things, or doing science labs.',
    ),
    InterestQuestion(
      id: 2,
      category: 'realistic',
      question:
          'I prefer learning by doing, rather than just reading about a topic.',
    ),
    InterestQuestion(
      id: 3,
      category: 'realistic',
      question:
          'I would rather work with tools and machinery than with abstract ideas.',
    ),
    InterestQuestion(
      id: 4,
      category: 'realistic',
      question:
          'I feel comfortable working outdoors in different weather conditions.',
    ),

    // Investigative (4 questions)
    InterestQuestion(
      id: 5,
      category: 'investigative',
      question:
          "I'm curious about how things work and enjoy solving complex problems or puzzles.",
    ),
    InterestQuestion(
      id: 6,
      category: 'investigative',
      question:
          'I like to research topics that interest me deeply and analyze information.',
    ),
    InterestQuestion(
      id: 7,
      category: 'investigative',
      question: "I'm fascinated by scientific and medical discoveries.",
    ),
    InterestQuestion(
      id: 8,
      category: 'investigative',
      question:
          'I enjoy digging into data to find patterns and draw conclusions.',
    ),

    // Artistic (4 questions)
    InterestQuestion(
      id: 9,
      category: 'artistic',
      question:
          'I enjoy expressing myself through creative activities like writing, music, drawing, or design.',
    ),
    InterestQuestion(
      id: 10,
      category: 'artistic',
      question: 'I prefer projects that allow for originality and imagination.',
    ),
    InterestQuestion(
      id: 11,
      category: 'artistic',
      question: 'I have a good sense of aesthetics, color, and design.',
    ),
    InterestQuestion(
      id: 12,
      category: 'artistic',
      question:
          "I'd rather write a fictional story or a poem than a technical report.",
    ),

    // Social (4 questions)
    InterestQuestion(
      id: 13,
      category: 'social',
      question:
          'I find it rewarding to help classmates, volunteer, or teach someone something new.',
    ),
    InterestQuestion(
      id: 14,
      category: 'social',
      question:
          'I enjoy working in groups and collaborating with others on projects.',
    ),
    InterestQuestion(
      id: 15,
      category: 'social',
      question:
          'I feel a strong desire to care for people who are sick or in need.',
    ),
    InterestQuestion(
      id: 16,
      category: 'social',
      question:
          'I am good at explaining things to people and listening to their concerns.',
    ),

    // Enterprising (4 questions)
    InterestQuestion(
      id: 17,
      category: 'enterprising',
      question:
          'I like to take the lead in group projects, persuade others, and organize events.',
    ),
    InterestQuestion(
      id: 18,
      category: 'enterprising',
      question: "I'm ambitious and enjoy a good debate or competition.",
    ),
    InterestQuestion(
      id: 19,
      category: 'enterprising',
      question:
          'I am drawn to activities like public speaking, debating, or selling a product.',
    ),
    InterestQuestion(
      id: 20,
      category: 'enterprising',
      question:
          'I am interested in business, managing money, and leading teams to achieve a goal.',
    ),

    // Conventional (4 questions)
    InterestQuestion(
      id: 21,
      category: 'conventional',
      question: 'I like to have a clear plan and organized notes when I study.',
    ),
    InterestQuestion(
      id: 22,
      category: 'conventional',
      question:
          "I'm good at keeping track of details and following instructions carefully.",
    ),
    InterestQuestion(
      id: 23,
      category: 'conventional',
      question:
          'I feel satisfied when I can organize information neatly in a spreadsheet or a file system.',
    ),
    InterestQuestion(
      id: 24,
      category: 'conventional',
      question:
          'I prefer tasks that have clear, well-defined procedures and predictable outcomes.',
    ),
  ];
}
