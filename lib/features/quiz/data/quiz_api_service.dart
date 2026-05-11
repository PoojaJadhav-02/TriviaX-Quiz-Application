import 'dart:convert';
import '../../../core/constants/api_constants.dart';
import '../models/question_model.dart';
import 'package:http/http.dart' as http;


class QuizApiService {
  Future<List<QuestionModel>> fetchQuestions(String difficulty) async {
    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}?limit=10&difficulty=$difficulty',
      ),
    );

    final data = jsonDecode(response.body);

    return List<QuestionModel>.from(
      data.map((e) => QuestionModel.fromJson(e)),
    );
  }
}