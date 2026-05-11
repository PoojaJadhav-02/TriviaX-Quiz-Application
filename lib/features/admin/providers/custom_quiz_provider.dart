import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../quiz/models/question_model.dart';

// class CustomQuizNotifier extends StateNotifier<List<QuestionModel>> {
//   CustomQuizNotifier() : super([]);
//
//   void addQuestion(QuestionModel question) {
//     state = [...state, question];
//   }
//
//   void deleteQuestion(int index) {
//     final updated = [...state];
//     updated.removeAt(index);
//     state = updated;
//   }
// }
//
// final customQuizProvider =
// StateNotifierProvider<CustomQuizNotifier, List<QuestionModel>>(
//       (ref) => CustomQuizNotifier(),
// );




final sampleQuestions = [
  {
    "question": "What is Flutter?",
    "options": [
      "Programming Language",
      "UI Toolkit",
      "Database",
      "Operating System"
    ],
    "correctAnswer": "UI Toolkit"
  },
];

final customQuizProvider =
StateProvider<List<Map<String, dynamic>>>(
      (ref) => sampleQuestions,
);