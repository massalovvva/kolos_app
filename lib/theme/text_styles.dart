import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  // Oswald — заголовки, лейблы, всё "спортивное"
  static TextStyle displayLarge = GoogleFonts.oswald(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle displayMedium = GoogleFonts.oswald(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle displaySmall = GoogleFonts.oswald(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 2.0,
    color: AppColors.textPrimary,
  );

  // Inter — основной текст
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static TextStyle label = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textMuted,
  );
}