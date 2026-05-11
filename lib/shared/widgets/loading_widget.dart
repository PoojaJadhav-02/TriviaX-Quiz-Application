import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

class AppLoadingWidget extends StatelessWidget {
  final String? message;
  final bool useShimmer;

  const AppLoadingWidget({
    super.key,
    this.message,
    this.useShimmer = false,
  });

  @override
  Widget build(BuildContext context) {
    if (useShimmer) {
      return _buildShimmerLoading();
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.primaryLight,
              backgroundColor: AppColors.glassBorder,
            ),
          ).animate(onPlay: (c) => c.repeat()).rotate(duration: 1200.ms),
          if (message != null) ...[
            const SizedBox(height: 20),
            Text(
              message!,
              style: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 14),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 400.ms),
          ],
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: List.generate(3, (index) {
          return Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.glassLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder),
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .shimmer(
                duration: 1500.ms,
                color: AppColors.primaryLight.withValues(alpha: 0.1),
              );
        }),
      ),
    );
  }
}