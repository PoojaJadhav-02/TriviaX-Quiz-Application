import '../data/quiz_api_service.dart';
import '../models/question_model.dart';

class QuizRepository {
  final QuizApiService apiService = QuizApiService();

  Future<List<QuestionModel>> getQuestions(String difficulty) async {
    return await apiService.fetchQuestions(difficulty);
  }
}