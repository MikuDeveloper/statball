import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:statball/app/global/constants.dart' show defaultRadius;

import 'theme_colors.dart';

class LightTheme {
  static ThemeData get themeData => ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: ThemeColors.backgroundLight,
    primaryColor: ThemeColors.accent,

    colorScheme: const ColorScheme.light(
      primary: ThemeColors.accent,
      onPrimary: ThemeColors.onAccent,
      secondary: ThemeColors.accentAlt,
      onSecondary: ThemeColors.onAccentAlt,
      surface: ThemeColors.surfaceLight,
      onSurface: ThemeColors.textPrimaryLight,
      error: ThemeColors.error,
      onError: ThemeColors.surfaceLight,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.w800,
      ),
      displayMedium: TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.w800,
      ),
      titleMedium: TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: ThemeColors.textPrimaryLight),
      bodyMedium: TextStyle(color: ThemeColors.textMutedLight),
      bodySmall: TextStyle(color: ThemeColors.textPrimaryLight),
      labelLarge: TextStyle(
        color: ThemeColors.textMutedLight,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: ThemeColors.textMutedLight,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: ThemeColors.textMutedLight,
        fontWeight: FontWeight.w500,
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: ThemeColors.backgroundLight,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: ThemeColors.textPrimaryLight),
      titleTextStyle: GoogleFonts.inter(
        color: ThemeColors.textPrimaryLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.accent,
        foregroundColor: ThemeColors.onAccent,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius / 2),
        ),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ThemeColors.textPrimaryLight,
        side: const BorderSide(color: ThemeColors.borderLight, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ThemeColors.surfaceLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: const TextStyle(color: ThemeColors.textMutedLight),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ThemeColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ThemeColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ThemeColors.accent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ThemeColors.error),
      ),
    ),

    cardTheme: CardThemeData(
      color: ThemeColors.surfaceLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ThemeColors.borderLight),
      ),
      margin: EdgeInsets.zero,
    ),

    dividerTheme: const DividerThemeData(
      color: ThemeColors.borderLight,
      thickness: 1,
      space: 1,
    ),
  );
}
