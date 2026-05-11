import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../quiz/models/question_model.dart';
import '../../quiz/providers/quiz_game_provider.dart';
import '../../quiz/providers/quiz_game_state.dart';
import '../../quiz/widgets/lives_widget.dart';
import '../../quiz/widgets/option_tile.dart';
import '../../quiz/widgets/progress_bar.dart';
import '../../quiz/widgets/score_widget.dart';
import '../providers/custom_quiz_provider.dart';

class CustomQuizScreen extends ConsumerStatefulWidget {
  const CustomQuizScreen({super.key});

  @override
  ConsumerState<CustomQuizScreen> createState() => _CustomQuizScreenState();
}

class _CustomQuizScreenState extends ConsumerState<CustomQuizScreen> {
  bool _initialized = false;



  @override
  Widget build(BuildContext context) {
    final customQuestions = ref.watch(customQuizProvider);
    final gameState = ref.watch(quizGameProvider);

    // Navigate to result when done
    ref.listen<QuizGameState>(quizGameProvider, (prev, next) {
      if ((next.isGameOver || next.isCompleted) &&
          prev != null &&
          !prev.isGameOver &&
          !prev.isCompleted) {
        Get.offNamed(AppRoutes.result, arguments: {
          'score': next.score,
          'correctCount': next.correctCount,
          'wrongCount': next.wrongCount,
          'accuracy': next.accuracy,
          'isGameOver': next.isGameOver,
          'totalQuestions': next.questions.length,
          'difficulty': 'custom',
        });
      }
    });

    // Empty state
    if (customQuestions.isEmpty) {
      return _EmptyCustomQuizScreen();
    }

    // Minimum check
    if (customQuestions.length < AppConstants.minAdminQuestions) {
      return _EmptyCustomQuizScreen();
    }

    // Initialize once
    if (!_initialized) {
      _initialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final converted = customQuestions.map((cq) {
          final incorrect = cq.allOptions.where((o) => o != cq.correctAnswer).toList();
          return QuestionModel(
            question: cq.question,
            correctAnswer: cq.correctAnswer,
            incorrectAnswers: incorrect,
          );
        }).toList();
        ref.read(quizGameProvider.notifier).initQuiz(converted);
      });
    }

    final q = gameState.currentQuestion;
    if (q == null || gameState.questions.isEmpty) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientMid, AppColors.gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(child: CircularProgressIndicator(color: AppColors.primaryLight)),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientMid, AppColors.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showQuitDialog(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.glassLight,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: QuizProgressBar(
                        progress: gameState.progress,
                        current: gameState.currentIndex + 1,
                        total: gameState.questions.length,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        'Custom',
                        style: GoogleFonts.poppins(
                          color: AppColors.accentLight,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Lives + Score
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LivesWidget(lives: gameState.lives),
                    ScoreWidget(score: gameState.score),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Question card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.1, 0),
                        end: Offset.zero,
                      ).animate(anim),
                      child: child,
                    ),
                  ),
                  child: Container(
                    key: ValueKey(gameState.currentIndex),
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: AppColors.glassLight,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColors.glassBorder),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Text(
                      q.question,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Options
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: gameState.currentShuffledAnswers.length,
                  itemBuilder: (context, i) {
                    final option = gameState.currentShuffledAnswers[i];
                    OptionState optState = OptionState.idle;

                    if (gameState.isAnswered) {
                      if (option == q.correctAnswer) {
                        optState = OptionState.correct;
                      } else if (option == gameState.selectedAnswer) {
                        optState = OptionState.wrong;
                      } else {
                        optState = OptionState.disabled;
                      }
                    }

                    return OptionTile(
                      key: ValueKey('${gameState.currentIndex}-$i'),
                      title: option,
                      index: i,
                      state: optState,
                      onTap: () =>
                          ref.read(quizGameProvider.notifier).selectAnswer(option),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showQuitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Quit Quiz?',
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700)),
        content: Text('Your progress will be lost.',
            style: GoogleFonts.poppins(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.primaryLight)),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(quizGameProvider.notifier).reset();
              Get.offAllNamed(AppRoutes.home);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.wrong,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('Quit',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _EmptyCustomQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.library_books_outlined,
                          size: 80, color: AppColors.accent)
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(begin: 0, end: -10, duration: 1500.ms, curve: Curves.easeInOut),
                  const SizedBox(height: 24),
                  Text(
                    'No Custom Questions',
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Go to Admin Panel and create at least 1 question first.',
                    style: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.admin),
                    icon: const Icon(Icons.admin_panel_settings_rounded),
                    label: Text('Go to Admin Panel',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: Get.back,
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: Text('Back', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: AppColors.glassBorder),
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}