import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';

class LivesWidget extends StatelessWidget {
  final int lives;
  final int maxLives;

  const LivesWidget({
    super.key,
    required this.lives,
    this.maxLives = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxLives, (i) {
        final isActive = i < lives;
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Icon(
            isActive ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isActive ? AppColors.liveActive : AppColors.liveInactive,
            size: 22,
          ).animate(key: ValueKey('$i-$isActive')).scale(
                duration: 300.ms,
                curve: Curves.elasticOut,
                begin: const Offset(0.7, 0.7),
                end: const Offset(1.0, 1.0),
              ),
        );
      }),
    );
  }
}