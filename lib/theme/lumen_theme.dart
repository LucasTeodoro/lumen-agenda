import 'package:flutter/material.dart';

class LumenColors {
  static const background = Color(0xFF09090B);
  static const card = Color(0xFF18181B);
  static const border = Color(0xFF27272A);
  static const text = Color(0xFFFAFAFA);
  static const muted = Color(0xFFA1A1AA);
  static const primary = Color(0xFFFAFAFA);
  static const primaryForeground = Color(0xFF18181B);
  static const accent = Color(0xFF27272A);
  static const destructive = Color(0xFFEF4444);
  static const ring = Color(0xFFD4D4D8);
}

class LumenTheme {
  static const radius = 8.0;
  static const cardRadius = 12.0;

  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: LumenColors.primary,
      onPrimary: LumenColors.primaryForeground,
      secondary: LumenColors.accent,
      onSecondary: LumenColors.text,
      surface: LumenColors.background,
      onSurface: LumenColors.text,
      error: LumenColors.destructive,
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
        fillColor: LumenColors.background,
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
          borderSide: const BorderSide(color: LumenColors.ring, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: LumenColors.destructive),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: LumenColors.destructive),
        ),
      ),
    );
  }
}
