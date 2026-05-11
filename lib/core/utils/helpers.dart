import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

Color difficultyColor(String difficulty) {
  switch (difficulty.toLowerCase()) {
    case 'easy':
      return AppColors.easyColor;
    case 'medium':
      return AppColors.mediumColor;
    case 'hard':
      return AppColors.hardColor;
    default:
      return AppColors.primary;
  }
}

String difficultyLabel(String difficulty) {
  switch (difficulty.toLowerCase()) {
    case 'easy':
      return '🟢 Easy';
    case 'medium':
      return '🟡 Medium';
    case 'hard':
      return '🔴 Hard';
    case 'custom':
      return '🟣 Custom';
    default:
      return difficulty.toUpperCase();
  }
}

/// Formats a timestamp-based ID into a display-friendly label.
String formatQuestionId(String id) => 'Q-${id.substring(id.length > 6 ? id.length - 6 : 0)}';