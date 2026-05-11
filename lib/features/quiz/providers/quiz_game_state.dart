import '../models/question_model.dart';

class QuizGameState {
  final List<QuestionModel> questions;
  final int currentIndex;
  final int score;
  final int lives;
  final List<String> currentShuffledAnswers;
  final String? selectedAnswer;
  final bool isAnswered;
  final bool isCorrect;
  final bool isGameOver;
  final bool isCompleted;
  final int correctCount;
  final int wrongCount;

  const QuizGameState({
    required this.questions,
    required this.currentIndex,
    required this.score,
    required this.lives,
    required this.currentShuffledAnswers,
    this.selectedAnswer,
    required this.isAnswered,
    required this.isCorrect,
    required this.isGameOver,
    required this.isCompleted,
    required this.correctCount,
    required this.wrongCount,
  });

  factory QuizGameState.initial() => const QuizGameState(
        questions: [],
        currentIndex: 0,
        score: 0,
        lives: 3,
        currentShuffledAnswers: [],
        selectedAnswer: null,
        isAnswered: false,
        isCorrect: false,
        isGameOver: false,
        isCompleted: false,
        correctCount: 0,
        wrongCount: 0,
      );

  QuestionModel? get currentQuestion =>
      questions.isEmpty ? null : questions[currentIndex];

  bool get isLastQuestion => currentIndex >= questions.length - 1;

  double get progress =>
      questions.isEmpty ? 0.0 : (currentIndex + 1) / questions.length;

  int get accuracy {
    final answered = correctCount + wrongCount;
    return answered == 0 ? 0 : (correctCount * 100 ~/ answered);
  }

  QuizGameState copyWith({
    List<QuestionModel>? questions,
    int? currentIndex,
    int? score,
    int? lives,
    List<String>? currentShuffledAnswers,
    String? selectedAnswer,
    bool? isAnswered,
    bool? isCorrect,
    bool? isGameOver,
    bool? isCompleted,
    int? correctCount,
    int? wrongCount,
    bool clearSelectedAnswer = false,
  }) {
    return QuizGameState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      lives: lives ?? this.lives,
      currentShuffledAnswers:
          currentShuffledAnswers ?? this.currentShuffledAnswers,
      selectedAnswer:
          clearSelectedAnswer ? null : (selectedAnswer ?? this.selectedAnswer),
      isAnswered: isAnswered ?? this.isAnswered,
      isCorrect: isCorrect ?? this.isCorrect,
      isGameOver: isGameOver ?? this.isGameOver,
      isCompleted: isCompleted ?? this.isCompleted,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
    );
  }
}
