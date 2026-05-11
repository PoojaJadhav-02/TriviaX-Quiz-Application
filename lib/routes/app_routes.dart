import 'package:get/get.dart';

import '../features/admin/screens/add_edit_question_screen.dart';
import '../features/admin/screens/admin_screen.dart';
import '../features/admin/screens/custom_quiz_screen.dart';
import '../features/quiz/screens/error_screen.dart';
import '../features/quiz/screens/home_screen.dart';
import '../features/quiz/screens/loading_screen.dart';
import '../features/quiz/screens/quiz_screen.dart';
import '../features/quiz/screens/result_screen.dart';
import '../features/quiz/screens/splash_screen.dart';


class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const quiz = '/quiz';
  static const result = '/result';
  static const loading = '/loading';
  static const error = '/error';
  static const admin = '/admin';
  static const addEditQuestion = '/add-edit-question';
  static const customQuiz = '/custom-quiz';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: quiz, page: () => const QuizScreen()),
    GetPage(name: result, page: () => const ResultScreen()),
    GetPage(name: loading, page: () => const LoadingScreen()),
    GetPage(name: error, page: () => const ErrorScreen()),
    GetPage(name: admin, page: () => const AdminScreen()),
    GetPage(
      name: addEditQuestion,
      page: () => const AddEditQuestionScreen(),
    ),
    GetPage(name: customQuiz, page: () => const CustomQuizScreen()),
  ];
}