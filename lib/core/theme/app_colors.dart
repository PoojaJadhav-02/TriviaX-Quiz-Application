import 'package:flutter/material.dart';

class AppColors {
  // Primary brand
  static const Color primary = Color(0xFF7C3AED);
  static const Color primaryLight = Color(0xFF9F67FF);
  static const Color primaryDark = Color(0xFF5B21B6);

  // Secondary accent
  static const Color accent = Color(0xFFEC4899);
  static const Color accentLight = Color(0xFFF472B6);

  // Gradient stops
  static const Color gradientStart = Color(0xFF1E1B4B); // deep indigo
  static const Color gradientMid = Color(0xFF3B0764);   // deep purple
  static const Color gradientEnd = Color(0xFF0F172A);   // dark slate

  // Difficulty colours
  static const Color easyColor = Color(0xFF10B981);   // emerald
  static const Color mediumColor = Color(0xFFF59E0B); // amber
  static const Color hardColor = Color(0xFFEF4444);   // red

  // Answer feedback
  static const Color correct = Color(0xFF22C55E);
  static const Color wrong = Color(0xFFEF4444);
  static const Color unanswered = Color(0xFF4F46E5);

  // Glassmorphism
  static const Color glassLight = Color(0x1AFFFFFF);
  static const Color glassDark = Color(0x14FFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);

  // Text
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFCBD5E1);
  static const Color textMuted = Color(0xFF94A3B8);

  // Background (dark)
  static const Color bgDark = Color(0xFF0F172A);
  static const Color bgCard = Color(0xFF1E293B);
  static const Color bgSurface = Color(0xFF334155);

  // Background (light)
  static const Color bgLight = Color(0xFFF1F5F9);
  static const Color bgLightCard = Color(0xFFFFFFFF);

  // Heart / lives
  static const Color liveActive = Color(0xFFEF4444);
  static const Color liveInactive = Color(0xFF475569);
}