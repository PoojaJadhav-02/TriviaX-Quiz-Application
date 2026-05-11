import 'dart:convert';
import 'dart:io';
import '../../../core/constants/api_constants.dart';
import '../models/question_model.dart';
import 'package:http/http.dart' as http;

class QuizApiService {
  static const Duration _timeout = Duration(seconds: 15);

  Future<List<QuestionModel>> fetchQuestions(String difficulty) async {
    try {
      final uri = Uri.parse(
        '${ApiConstants.baseUrl}?limit=10&difficulty=$difficulty',
      );

      final response = await http.get(uri).timeout(
        _timeout,
        onTimeout: () => throw const SocketException('Request timed out'),
      );

      if (response.statusCode != 200) {
        throw Exception('Server error: ${response.statusCode}');
      }

      final List data = jsonDecode(response.body) as List;

      if (data.isEmpty) {
        throw Exception('No questions returned from API');
      }

      return data.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>)).toList();
    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      rethrow;
    }
  }
}