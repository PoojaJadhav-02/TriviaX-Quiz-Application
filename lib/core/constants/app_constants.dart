class AppConstants {
  static const String appName = 'TriviaX';
  static const String appTagline = 'Test Your Knowledge';

  // Game settings
  static const int maxLives = 3;
  static const int scorePerCorrect = 10;
  static const int maxQuestions = 10;
  static const int minAdminQuestions = 1;
  static const int maxAdminQuestions = 10;
  static const int answerFeedbackDelayMs = 1400;
  static const int splashDurationSeconds = 3;

  // Score thresholds
  static const int confettiScoreThreshold = 60; // % accuracy for confetti

  // SharedPreferences keys
  static const String themeKey = 'is_dark_mode';
  static const String customQuestionsKey = 'custom_questions';

  // Difficulty labels
  static const String easy = 'easy';
  static const String medium = 'medium';
  static const String hard = 'hard';
}