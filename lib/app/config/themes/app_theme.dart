import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // ══════════════════════════════════════════════════════════════════════════
  //  TEXT THEMES (Tipografía)
  // ══════════════════════════════════════════════════════════════════════════

  static TextTheme _lightTextTheme() {
    return GoogleFonts.robotoTextTheme().copyWith(
      // ── Displays (Para números gigantes, puntajes en Statball)
      displayLarge: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 57,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 45,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 36,
        fontWeight: FontWeight.w600,
      ),

      // ── Headlines (Títulos de pantallas)
      headlineLarge: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),

      // ── Titles (Títulos de tarjetas, AppBars)
      titleLarge: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),

      // ── Body (Textos descriptivos, listas, contenido general)
      bodyLarge: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),

      // ── Labels (Botones, chips, inputs, leyendas pequeñas)
      labelLarge: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ), // Botones
      labelMedium: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }

  static TextTheme _darkTextTheme() {
    return GoogleFonts.robotoTextTheme().copyWith(
      // ── Displays (Puntajes y métricas grandes)
      displayLarge: const TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 57,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: const TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 45,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: const TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 36,
        fontWeight: FontWeight.w600,
      ),

      // ── Headlines
      headlineLarge: const TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: const TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: const TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),

      // ── Titles
      titleLarge: const TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: const TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: const TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),

      // ── Body (Usamos el nuevo textSecondaryDark para mejor legibilidad prolongada)
      bodyLarge: const TextStyle(
        color: AppColors.textSecondaryDark,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: const TextStyle(
        color: AppColors.textSecondaryDark,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),

      // ── Labels
      labelLarge: const TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  THEME DATA (Integración final)
  // ══════════════════════════════════════════════════════════════════════════

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.bgLight,
      primaryColor: AppColors.accent,
      textTheme: _lightTextTheme(),

      // Configuración de tarjetas basada en tus colores
      cardTheme: const CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.cardBorder, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      // Colores de componentes comunes
      dividerColor: AppColors.divider,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        secondary: AppColors.accentAlt,
        surface: AppColors.card,
        error: AppColors.error,
        onPrimary: AppColors.onAccent,
        onSecondary: AppColors.onAccentAlt,
      ),
      inputDecorationTheme: _lightInputDecorationTheme(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgDark,
      primaryColor: AppColors.accent,
      textTheme: _darkTextTheme(),

      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.inputBorder, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      dividerColor: AppColors.inputBorder,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accentAlt,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.onAccent,
        onSecondary: AppColors.onAccentAlt,
      ),
      inputDecorationTheme: _darkInputDecorationTheme(),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  INPUT DECORATION THEMES (Formularios)
  // ══════════════════════════════════════════════════════════════════════════

  static InputDecorationTheme _lightInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.card, // Fondo blanco para inputs en modo claro
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14.5),
      errorStyle: const TextStyle(
        color: AppColors.error,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      // Colores de los iconos por defecto
      prefixIconColor: AppColors.textMuted,
      prefixIconConstraints: const BoxConstraints(minWidth: 52, minHeight: 52),
      suffixIconColor: AppColors.textMuted,
      suffixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      // Bordes
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.cardBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.cardBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }

  static InputDecorationTheme _darkInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor:
          AppColors.surfaceElevated, // El que tenías en tu método original
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14.5),
      errorStyle: const TextStyle(
        color: AppColors.error,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: AppColors.textMuted,
      prefixIconConstraints: const BoxConstraints(minWidth: 52, minHeight: 52),
      suffixIconColor: AppColors.textMuted,
      suffixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }
}
