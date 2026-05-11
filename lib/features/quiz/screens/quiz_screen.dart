import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../providers/quiz_game_provider.dart';
import '../providers/quiz_provider.dart';
import '../providers/quiz_game_state.dart';
import '../widgets/lives_widget.dart';
import '../widgets/option_tile.dart';
import '../widgets/progress_bar.dart';
import '../widgets/score_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/loading_widget.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  late String difficulty;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    difficulty = Get.arguments as String? ?? 'easy';
  }

  @override
  Widget build(BuildContext context) {
    final quizAsync = ref.watch(quizProvider(difficulty));
    final gameState = ref.watch(quizGameProvider);

    // Navigate to result when game ends
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
          'difficulty': difficulty,
        });
      }
    });

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
          child: quizAsync.when(
            loading: () => const AppLoadingWidget(
              message: 'Loading questions...',
              useShimmer: true,
            ),
            error: (e, _) => AppErrorWidget(
              message: e.toString().replaceAll('Exception:', '').trim(),
              onRetry: () => ref.invalidate(quizProvider(difficulty)),
            ),
            data: (questions) {
              // Initialize once when questions arrive
              if (!_initialized) {
                _initialized = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(quizGameProvider.notifier).initQuiz(questions);
                });
                return const AppLoadingWidget(message: 'Setting up quiz...');
              }

              final q = gameState.currentQuestion;
              if (q == null) return const AppLoadingWidget();

              return Column(
                children: [
                  // Top bar
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: QuizProgressBar(
                            progress: gameState.progress,
                            current: gameState.currentIndex + 1,
                            total: gameState.questions.length,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Lives + Score row
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

                  // Question Card
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
                              color: AppColors.primary.withValues(alpha: 0.2),
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
                          onTap: () => ref
                              .read(quizGameProvider.notifier)
                              .selectAnswer(option),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
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
        title: Text('Quit Quiz?', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700)),
        content: Text(
          'Your progress will be lost.',
          style: GoogleFonts.poppins(color: AppColors.textSecondary),
        ),
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
            child: Text('Quit', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}