import 'dart:convert';

class CustomQuestionModel {
  final String id;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctAnswer;

  const CustomQuestionModel({
    required this.id,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctAnswer,
  });

  List<String> get allOptions => [optionA, optionB, optionC, optionD];

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'optionA': optionA,
        'optionB': optionB,
        'optionC': optionC,
        'optionD': optionD,
        'correctAnswer': correctAnswer,
      };

  factory CustomQuestionModel.fromJson(Map<String, dynamic> json) {
    return CustomQuestionModel(
      id: json['id'] as String,
      question: json['question'] as String,
      optionA: json['optionA'] as String,
      optionB: json['optionB'] as String,
      optionC: json['optionC'] as String,
      optionD: json['optionD'] as String,
      correctAnswer: json['correctAnswer'] as String,
    );
  }

  CustomQuestionModel copyWith({
    String? id,
    String? question,
    String? optionA,
    String? optionB,
    String? optionC,
    String? optionD,
    String? correctAnswer,
  }) {
    return CustomQuestionModel(
      id: id ?? this.id,
      question: question ?? this.question,
      optionA: optionA ?? this.optionA,
      optionB: optionB ?? this.optionB,
      optionC: optionC ?? this.optionC,
      optionD: optionD ?? this.optionD,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }

  static String encodeList(List<CustomQuestionModel> list) =>
      jsonEncode(list.map((e) => e.toJson()).toList());

  static List<CustomQuestionModel> decodeList(String json) {
    final List decoded = jsonDecode(json) as List;
    return decoded.map((e) => CustomQuestionModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
