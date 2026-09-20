import 'package:flutter/material.dart';

class LumenColors {
  static const background = Color(0xFF070B18);
  static const card = Color(0xCC0E1530);
  static const border = Color(0x5530E5C8);
  static const text = Color(0xFFF4F7FF);
  static const muted = Color(0xFF8B93B0);
  static const teal = Color(0xFF00E5C0);
  static const violet = Color(0xFF7B61FF);
  static const pink = Color(0xFFFF4D8D);
  static const primary = teal;
  static const primaryForeground = Color(0xFF04120F);
  static const accent = Color(0xFF1A1540);
  static const destructive = pink;
  static const ring = teal;
}

class LumenTheme {
  static const radius = 8.0;
  static const cardRadius = 12.0;

  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: LumenColors.teal,
      onPrimary: LumenColors.primaryForeground,
      secondary: LumenColors.violet,
      onSecondary: LumenColors.text,
      tertiary: LumenColors.pink,
      surface: LumenColors.background,
      onSurface: LumenColors.text,
      error: LumenColors.pink,
      outline: LumenColors.border,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: LumenColors.background,
      dividerColor: LumenColors.border,
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          color: LumenColors.text,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: LumenColors.text,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: LumenColors.text,
        ),
        bodyLarge: TextStyle(color: LumenColors.text, height: 1.45),
        bodyMedium: TextStyle(color: LumenColors.muted, height: 1.45),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0x33070B18),
        hintStyle: const TextStyle(color: LumenColors.muted, fontSize: 14),
        labelStyle: const TextStyle(color: LumenColors.muted, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: LumenColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: LumenColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: LumenColors.teal, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: LumenColors.pink),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: LumenColors.pink),
        ),
      ),
    );
  }
}
