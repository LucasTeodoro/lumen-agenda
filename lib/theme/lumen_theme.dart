import 'package:flutter/material.dart';

class LumenColors {
  static const background = Color(0xFF070B18);
  static const teal = Color(0xFF00E5C0);
  static const violet = Color(0xFF7B61FF);
  static const pink = Color(0xFFFF4D8D);
  static const text = Color(0xFFF4F7FF);
  static const muted = Color(0xFF8B93B0);
  static const glass = Color(0x22FFFFFF);
  static const glassBorder = Color(0x33FFFFFF);
}

class LumenTheme {
  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: LumenColors.teal,
      secondary: LumenColors.violet,
      tertiary: LumenColors.pink,
      surface: LumenColors.background,
      onSurface: LumenColors.text,
      onPrimary: Color(0xFF04120F),
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: LumenColors.background,
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
          color: LumenColors.text,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w700,
          color: LumenColors.text,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w700,
          color: LumenColors.text,
        ),
        bodyLarge: TextStyle(color: LumenColors.text, height: 1.4),
        bodyMedium: TextStyle(color: LumenColors.muted, height: 1.4),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0x330B1026),
        hintStyle: const TextStyle(color: LumenColors.muted),
        labelStyle: const TextStyle(color: LumenColors.muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: LumenColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: LumenColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: LumenColors.teal, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: LumenColors.pink),
        ),
      ),
    );
  }
}
