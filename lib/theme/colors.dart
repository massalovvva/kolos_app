import 'package:flutter/material.dart';

class AppColors {
  // Фон
  static const background = Color(0xFF0D1117);
  static const surface = Color(0xFF161B22);
  static const surfaceHover = Color(0xFF1C2330);

  // Границы
  static const border = Color(0xFF2A3140);
  static const borderFocus = Colors.white;

  // Текст
  static const textPrimary = Color(0xFFEDF1F7);
  static const textMuted = Color(0xFF8B95A7);
  static const textOnAccent = Color(0xFF0D1117);

  // Акцент (единственный яркий цвет — клубный чёрно-белый стиль)
  static const accent = Colors.white;
  static const accentDim = Color(0xFF4A5568);

  // Статусы готовности (функциональные цвета, не брендинг)
  static const statusReady = Color(0xFF3FBF7F);    // зелёный, 75-100%
  static const statusModerate = Color(0xFFE8B93F); // жёлтый, 50-74%
  static const statusCaution = Color(0xFFE8544B);  // красный, 0-49%
}