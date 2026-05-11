import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../routes/app_routes.dart';
import '../widgets/difficulty_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientMid, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [const Color(0xFFEDE9FE), const Color(0xFFF5F3FF), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo + Title
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryLight],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 10),
                            ],
                          ),
                          child: const Icon(Icons.quiz_rounded, color: Colors.white, size: 22),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'TriviaX',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AppColors.gradientStart,
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),

                    // Theme toggle
                    Obx(() => GestureDetector(
                          onTap: themeCtrl.toggleTheme,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.glassLight,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.glassBorder),
                            ),
                            child: Icon(
                              themeCtrl.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                              color: isDark ? Colors.white : AppColors.gradientStart,
                              size: 20,
                            ),
                          ),
                        )).animate(delay: 200.ms).fadeIn().scale(),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Hero section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryDark],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 36),
                            const SizedBox(height: 12),
                            Text(
                              'Ready to Play?',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Choose a difficulty level and test your trivia knowledge!',
                              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
                            ),
                          ],
                        ),
                      ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),

                      const SizedBox(height: 30),

                      Text(
                        'Choose Difficulty',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: isDark ? Colors.white : AppColors.gradientStart,
                        ),
                      ).animate(delay: 200.ms).fadeIn(),

                      const SizedBox(height: 20),

                      DifficultyCard(
                        label: 'Easy',
                        subtitle: 'Perfect for beginners',
                        icon: Icons.sentiment_satisfied_rounded,
                        color: AppColors.easyColor,
                        animIndex: 0,
                        onTap: () => Get.toNamed(AppRoutes.quiz, arguments: 'easy'),
                      ),
                      const SizedBox(height: 12),
                      DifficultyCard(
                        label: 'Medium',
                        subtitle: 'For the average trivia fan',
                        icon: Icons.psychology_rounded,
                        color: AppColors.mediumColor,
                        animIndex: 1,
                        onTap: () => Get.toNamed(AppRoutes.quiz, arguments: 'medium'),
                      ),
                      const SizedBox(height: 12),
                      DifficultyCard(
                        label: 'Hard',
                        subtitle: 'Only for experts!',
                        icon: Icons.local_fire_department_rounded,
                        color: AppColors.hardColor,
                        animIndex: 2,
                        onTap: () => Get.toNamed(AppRoutes.quiz, arguments: 'hard'),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        'Custom',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: isDark ? Colors.white : AppColors.gradientStart,
                        ),
                      ).animate(delay: 500.ms).fadeIn(),

                      const SizedBox(height: 14),

                      // Play Custom Quiz
                      _ActionCard(
                        label: 'Play Custom Quiz',
                        subtitle: 'Play admin-created questions',
                        icon: Icons.play_circle_outline_rounded,
                        color: AppColors.primaryLight,
                        animIndex: 3,
                        onTap: () => Get.toNamed(AppRoutes.customQuiz),
                      ),

                      // Admin Panel
                      _ActionCard(
                        label: 'Admin Panel',
                        subtitle: 'Create & manage custom questions',
                        icon: Icons.admin_panel_settings_rounded,
                        color: AppColors.accent,
                        animIndex: 4,
                        onTap: () => Get.toNamed(AppRoutes.admin),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String label;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final int animIndex;

  const _ActionCard({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.animIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 15, color: color)),
                  Text(subtitle,
                      style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: color.withValues(alpha: 0.7)),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 100 * animIndex))
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.1, end: 0);
  }
}