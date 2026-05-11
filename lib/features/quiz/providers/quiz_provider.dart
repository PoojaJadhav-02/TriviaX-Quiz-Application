import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question_model.dart';
import '../repository/quiz_repository.dart';

final quizProvider = FutureProvider.family<List<QuestionModel>, String>(
      (ref, difficulty) async {
    return QuizRepository().getQuestions(difficulty);
  },
);