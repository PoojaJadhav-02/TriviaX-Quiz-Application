import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../models/question_model.dart';
import 'quiz_game_state.dart';

class QuizGameNotifier extends StateNotifier<QuizGameState> {
  QuizGameNotifier() : super(QuizGameState.initial());

  /// Initializes (or resets) the quiz with a list of questions.
  void initQuiz(List<QuestionModel> questions) {
    if (questions.isEmpty) return;
    final shuffled = _shuffle(questions[0]);
    state = QuizGameState(
      questions: questions,
      currentIndex: 0,
      score: 0,
      lives: AppConstants.maxLives,
      currentShuffledAnswers: shuffled,
      selectedAnswer: null,
      isAnswered: false,
      isCorrect: false,
      isGameOver: false,
      isCompleted: false,
      correctCount: 0,
      wrongCount: 0,
    );
  }

  /// Called when user taps an answer option.
  void selectAnswer(String answer) {
    if (state.isAnswered || state.currentQuestion == null) return;

    final isCorrect = answer == state.currentQuestion!.correctAnswer;
    final newScore = isCorrect ? state.score + AppConstants.scorePerCorrect : state.score;
    final newLives = isCorrect ? state.lives : state.lives - 1;
    final newCorrectCount = isCorrect ? state.correctCount + 1 : state.correctCount;
    final newWrongCount = isCorrect ? state.wrongCount : state.wrongCount + 1;
    final isLast = state.isLastQuestion;

    state = state.copyWith(
      selectedAnswer: answer,
      isAnswered: true,
      isCorrect: isCorrect,
      score: newScore,
      lives: newLives,
      correctCount: newCorrectCount,
      wrongCount: newWrongCount,
    );

    // Auto-advance after feedback delay
    Future.delayed(
      Duration(milliseconds: AppConstants.answerFeedbackDelayMs),
      () {
        if (!mounted) return;
        if (newLives <= 0) {
          state = state.copyWith(isGameOver: true);
        } else if (isLast) {
          state = state.copyWith(isCompleted: true);
        } else {
          _nextQuestion();
        }
      },
    );
  }

  void _nextQuestion() {
    if (!mounted) return;
    final nextIndex = state.currentIndex + 1;
    if (nextIndex >= state.questions.length) {
      state = state.copyWith(isCompleted: true);
      return;
    }
    final shuffled = _shuffle(state.questions[nextIndex]);
    state = state.copyWith(
      currentIndex: nextIndex,
      currentShuffledAnswers: shuffled,
      isAnswered: false,
      isCorrect: false,
      clearSelectedAnswer: true,
    );
  }

  void reset() => state = QuizGameState.initial();

  List<String> _shuffle(QuestionModel q) {
    final opts = [...q.incorrectAnswers, q.correctAnswer];
    opts.shuffle();
    return opts;
  }
}

final quizGameProvider =
    StateNotifierProvider<QuizGameNotifier, QuizGameState>(
  (ref) => QuizGameNotifier(),
);
