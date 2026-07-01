import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_colors.dart';

class LightTheme {
  static ThemeData get themeData => ThemeData(
    useMaterial3: true,
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

    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: const TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: const TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: const TextStyle(color: ThemeColors.textPrimaryLight),
      bodyMedium: const TextStyle(color: ThemeColors.textMutedLight),
      labelLarge: const TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontWeight: FontWeight.w500,
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.backgroundLight,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: ThemeColors.textPrimaryLight),
      titleTextStyle: TextStyle(
        color: ThemeColors.textPrimaryLight,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.accent,
        foregroundColor: ThemeColors.onAccent,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ThemeColors.textPrimaryLight,
        side: const BorderSide(color: ThemeColors.borderLight, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
