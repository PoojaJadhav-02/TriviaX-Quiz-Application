class QuestionModel {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  QuestionModel({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      correctAnswer: json['correctAnswer'],
      incorrectAnswers:
      List<String>.from(json['incorrectAnswers']),
    );
  }

  List<String> get shuffledAnswers {
    final answers = [...incorrectAnswers, correctAnswer];
    answers.shuffle();
    return answers;
  }
}