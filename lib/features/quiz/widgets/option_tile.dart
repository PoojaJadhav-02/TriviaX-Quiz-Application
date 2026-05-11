import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class OptionTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final OptionState state;
  final int index;

  const OptionTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.state,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color borderColor;
    Color textColor;
    Widget? trailingIcon;

    switch (state) {
      case OptionState.correct:
        bgColor = AppColors.correct.withValues(alpha: 0.2);
        borderColor = AppColors.correct;
        textColor = AppColors.correct;
        trailingIcon = const Icon(Icons.check_circle_rounded, color: AppColors.correct, size: 22);
        break;
      case OptionState.wrong:
        bgColor = AppColors.wrong.withValues(alpha: 0.2);
        borderColor = AppColors.wrong;
        textColor = AppColors.wrong;
        trailingIcon = const Icon(Icons.cancel_rounded, color: AppColors.wrong, size: 22);
        break;
      case OptionState.disabled:
        bgColor = AppColors.glassLight;
        borderColor = AppColors.glassBorder;
        textColor = AppColors.textMuted;
        trailingIcon = null;
        break;
      default:
        bgColor = AppColors.glassLight;
        borderColor = AppColors.glassBorder;
        textColor = AppColors.textPrimary;
        trailingIcon = null;
    }

    return GestureDetector(
      onTap: state == OptionState.idle ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: borderColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor.withValues(alpha: 0.5)),
              ),
              child: Center(
                child: Text(
                  ['A', 'B', 'C', 'D'][index % 4],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: borderColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            if (trailingIcon != null) trailingIcon,
          ],
        ),
      ),
    ).animate(delay: Duration(milliseconds: 60 * index)).fadeIn().slideX(begin: 0.1, end: 0);
  }
}

enum OptionState { idle, correct, wrong, disabled }