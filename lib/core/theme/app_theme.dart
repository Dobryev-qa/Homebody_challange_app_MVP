import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF0B0B0C);
  static const surface = Color(0xFF141416);
  static const surfaceSoft = Color(0xFF1A1A1D);

  static const primary = Color(0xFFE53935); // красный
  static const primarySoft = Color(0x33E53935);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF9E9E9E);
  static const textMuted = Color(0xFF6E6E73);

  static const border = Color(0x22FFFFFF);
}

// Типография
class AppTextStyles {
  static const titleXL = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.2,
    color: AppColors.textPrimary,
  );

  static const titleL = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const titleM = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const caption = TextStyle(
    fontSize: 12,
    color: AppColors.textMuted,
    letterSpacing: 1.1,
  );
}
