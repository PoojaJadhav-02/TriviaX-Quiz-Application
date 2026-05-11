import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiCtrl;
  late Map<String, dynamic> _args;
  late int score;
  late int correctCount;
  late int wrongCount;
  late int accuracy;
  late bool isGameOver;
  late int totalQuestions;
  late String difficulty;

  @override
  void initState() {
    super.initState();
    _args = (Get.arguments as Map<String, dynamic>?) ?? {};
    score = _args['score'] as int? ?? 0;
    correctCount = _args['correctCount'] as int? ?? 0;
    wrongCount = _args['wrongCount'] as int? ?? 0;
    accuracy = _args['accuracy'] as int? ?? 0;
    isGameOver = _args['isGameOver'] as bool? ?? false;
    totalQuestions = _args['totalQuestions'] as int? ?? 0;
    difficulty = _args['difficulty'] as String? ?? 'easy';

    _confettiCtrl = ConfettiController(duration: const Duration(seconds: 3));

    if (!isGameOver && accuracy >= AppConstants.confettiScoreThreshold) {
      Future.delayed(const Duration(milliseconds: 300), _confettiCtrl.play);
    }
  }

  @override
  void dispose() {
    _confettiCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool passed = !isGameOver && accuracy >= AppConstants.confettiScoreThreshold;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.gradientStart, AppColors.gradientMid, AppColors.gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Confetti
          ConfettiWidget(
            confettiController: _confettiCtrl,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 40,
            colors: const [
              AppColors.easyColor, AppColors.mediumColor, AppColors.primaryLight, Colors.white, AppColors.accent
            ],
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // Status icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (passed ? AppColors.easyColor : AppColors.wrong).withValues(alpha: 0.2),
                      border: Border.all(
                        color: passed ? AppColors.easyColor : AppColors.wrong,
                        width: 3,
                      ),
                    ),
                    child: Icon(
                      passed ? Icons.emoji_events_rounded : Icons.sentiment_dissatisfied_rounded,
                      size: 50,
                      color: passed ? AppColors.easyColor : AppColors.wrong,
                    ),
                  )
                      .animate()
                      .scale(duration: 600.ms, curve: Curves.elasticOut)
                      .fadeIn(duration: 400.ms),

                  const SizedBox(height: 16),

                  Text(
                    isGameOver ? 'Game Over!' : (passed ? 'Excellent!' : 'Quiz Complete!'),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2),

                  Text(
                    isGameOver
                        ? 'You ran out of lives'
                        : (passed ? 'Amazing performance!' : 'Keep practising!'),
                    style: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 14),
                  ).animate(delay: 300.ms).fadeIn(),

                  const SizedBox(height: 32),

                  // Score card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.glassLight,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Column(
                      children: [
                        // Big score
                        Text(
                          '$score',
                          style: GoogleFonts.poppins(
                            fontSize: 56,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryLight,
                          ),
                        ),
                        Text(
                          'Total Points',
                          style: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 13),
                        ),

                        const Divider(color: AppColors.glassBorder, height: 32),

                        // Stats row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _StatItem(label: 'Correct', value: '$correctCount', color: AppColors.easyColor),
                            _StatItem(label: 'Wrong', value: '$wrongCount', color: AppColors.wrong),
                            _StatItem(label: 'Accuracy', value: '$accuracy%', color: AppColors.mediumColor),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Accuracy bar
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Accuracy', style: GoogleFonts.poppins(color: AppColors.textMuted, fontSize: 12)),
                                Text('$accuracy%',
                                    style: GoogleFonts.poppins(
                                        color: AppColors.primaryLight, fontSize: 12, fontWeight: FontWeight.w700)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: accuracy / 100,
                                minHeight: 8,
                                backgroundColor: AppColors.glassBorder,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  accuracy >= 70 ? AppColors.easyColor : AppColors.mediumColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.15),

                  const Spacer(),

                  // Action buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.offNamed(AppRoutes.quiz, arguments: difficulty);
                    },
                    icon: const Icon(Icons.replay_rounded),
                    label: Text('Play Again', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 4,
                      shadowColor: AppColors.primary.withValues(alpha: 0.4),
                    ),
                  ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2),

                  const SizedBox(height: 12),

                  OutlinedButton.icon(
                    onPressed: () => Get.offAllNamed(AppRoutes.home),
                    icon: const Icon(Icons.home_rounded),
                    label: Text('Back to Home', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: AppColors.glassBorder, width: 1.5),
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ).animate(delay: 700.ms).fadeIn(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: GoogleFonts.poppins(color: color, fontSize: 22, fontWeight: FontWeight.w700)),
        Text(label,
            style: GoogleFonts.poppins(color: AppColors.textMuted, fontSize: 11)),
      ],
    );
  }
}