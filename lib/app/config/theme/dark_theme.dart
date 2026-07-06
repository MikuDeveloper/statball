import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_colors.dart';

class DarkTheme {
  static ThemeData get themeData => ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: ThemeColors.backgroundDark,
    primaryColor: ThemeColors.accentDark,

    colorScheme: const ColorScheme.dark(
      primary: ThemeColors.accentDark,
      onPrimary: ThemeColors.onAccent,
      secondary: ThemeColors.accentAlt,
      onSecondary: ThemeColors.onAccentAlt,
      // Usamos un gris muy oscuro y profundo, ligeramente más claro que el fondo
      surface: ThemeColors.surfaceDark,
      onSurface: ThemeColors.textPrimaryDark,
      error: ThemeColors.error,
      onError: ThemeColors.surfaceDark, // Color(0xFF0A0A0F),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: ThemeColors.textPrimaryDark,
        fontWeight: FontWeight.w800,
      ),
      displayMedium: TextStyle(
        color: ThemeColors.textPrimaryDark,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: ThemeColors.textPrimaryDark,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        color: ThemeColors.textPrimaryDark,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: TextStyle(
        color: ThemeColors.textPrimaryDark,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: ThemeColors.textPrimaryDark,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: ThemeColors.textPrimaryDark,
        fontWeight: FontWeight.w800,
      ),
      titleMedium: TextStyle(
        color: ThemeColors.textPrimaryDark,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: ThemeColors.textPrimaryDark,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: ThemeColors.textPrimaryDark),
      bodyMedium: TextStyle(color: ThemeColors.textMutedDark),
      bodySmall: TextStyle(color: ThemeColors.textPrimaryDark),
      labelLarge: TextStyle(
        color: ThemeColors.textMutedDark,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: ThemeColors.textMutedDark,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: ThemeColors.textMutedDark,
        fontWeight: FontWeight.w500,
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: ThemeColors.backgroundDark,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: ThemeColors.textPrimaryDark),
      titleTextStyle: GoogleFonts.inter(
        color: ThemeColors.textPrimaryDark,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.accentDark,
        foregroundColor: ThemeColors.onAccent,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ThemeColors.textPrimaryDark,
        side: const BorderSide(color: ThemeColors.borderDark, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ThemeColors.surfaceDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: const TextStyle(color: ThemeColors.textMutedDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ThemeColors.borderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ThemeColors.borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ThemeColors.accentDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ThemeColors.error),
      ),
    ),

    cardTheme: CardThemeData(
      color: ThemeColors.surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ThemeColors.borderDark),
      ),
      margin: EdgeInsets.zero,
    ),

    dividerTheme: const DividerThemeData(
      color: ThemeColors.borderDark,
      thickness: 1,
      space: 1,
    ),
  );
}
