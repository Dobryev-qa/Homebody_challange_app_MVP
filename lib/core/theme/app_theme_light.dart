import 'package:flutter/material.dart';

class AppColorsLight {
  static const background = Color(0xFFF5F6F8);      // не чисто белый
  static const surface = Color(0xFFFFFFFF);        // карточки
  static const surfaceSoft = Color(0xFFF0F1F3);

  static const primary = Color(0xFFE53935);         // тот же красный
  static const primarySoft = Color(0x1AE53935);

  static const textPrimary = Color(0xFF0E0E11);     // почти чёрный
  static const textSecondary = Color(0xFF4A4A4F);
  static const textMuted = Color(0xFF8E8E93);

  static const border = Color(0x1A000000);
}

// Типография для light темы
class AppTextStylesLight {
  static const titleXL = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.2,
    color: AppColorsLight.textPrimary,
  );

  static const titleL = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColorsLight.textPrimary,
  );

  static const titleM = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColorsLight.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColorsLight.textSecondary,
    height: 1.4,
  );

  static const caption = TextStyle(
    fontSize: 12,
    color: AppColorsLight.textMuted,
    letterSpacing: 1.1,
  );
}
