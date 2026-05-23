import 'package:flutter/material.dart';

// ════════════════════════════════════════════════════════════════════════════
//  APP COLORS — paleta compartida en toda la app Statball
//
//  · Auth screens  (Splash / Login / Reset): fondo oscuro  → bg, surface…
//  · App screens   (Dashboard y siguientes): fondo claro   → bgLight, card…
// ════════════════════════════════════════════════════════════════════════════
class AppColors {
  AppColors._();

  // ── Pantallas de autenticación (fondo oscuro) ───────────────────────────
  static const bgDark = Color(0xFF0A0A0F);
  static const surface = Color(0xFF13131A);
  static const surfaceElevated = Color(0xFF1C1C27);
  static const inputBorder = Color(0xFF2A2A3A);

  // ── Pantallas internas de la app (fondo claro) ──────────────────────────
  static const bgLight = Color(0xFFF7F7FA); // fondo de página
  static const card = Color(0xFFFFFFFF); // tarjetas blancas
  static const cardBorder = Color(0xFFECECF0); // borde sutil
  static const divider = Color(0xFFF0F0F5); // separadores

  // ── Texto ────────────────────────────────────────────────────────────────
  static const textPrimary = Color(0xFF0A0A0F);
  static const textPrimaryDark = Color(0xFFF0F0F5);
  static const textSecondary = Color(0xFF3A3A4A);
  static const textSecondaryDark = Color(0xFFB4B4C0);
  static const textMuted = Color(0xFF8A8A9A);

  // ── Acento principal — verde neón ────────────────────────────────────────
  static const accent = Color(0xFF00E5A0);
  static const accentDark = Color(0xFF00C98A); // texto / iconos sobre claro
  static const accentSurface = Color(0xFFE6FBF4); // fondo de chips verdes
  static const accentBorder = Color(0x3300E5A0); // borde semitransparente

  // ── Acento secundario — violeta ──────────────────────────────────────────
  static const accentAlt = Color(0xFF7B2FFF);
  static const accentAltSurface = Color(0xFFEDE9FF);
  static const accentAltBorder = Color(0x337B2FFF);

  // ── On-Colors (Texto e iconos sobre acentos) ─────────────────────────────
  static const onAccent = Color(0xFF0A0A0F); // Negro/Gris muy oscuro
  static const onAccentAlt = Color(0xFFFFFFFF); // Blanco

  // ── Estados de Interacción (Disabled) ────────────────────────────────────
  static const bgDisabled = Color(0xFFE2E2E8);
  static const textDisabled = Color(0xFFA0A0B0);

  // ── Sombras y Overlays ───────────────────────────────────────────────────
  static const shadow = Color(0x1A0A0A0F); // 10% de tu bgDark
  static const overlay = Color(0xB30A0A0F); // 70% de opacidad para modales

  // ── Data Visualization (Gráficos y Estadísticas) ─────────────────────────
  static const chartTeamA = Color(0xFF00E5A0); // Reutiliza el acento
  static const chartTeamB = Color(0xFF7B2FFF); // Reutiliza el acento alterno
  static const chartNeutral = Color(0xFF38BDF8); // Un azul vibrante

  // ── Semánticos ───────────────────────────────────────────────────────────
  static const success = Color(0xFF00B373);
  static const error = Color(0xFFFF4D6A);
  static const warning = Color(0xFFF0B429);
  static const warningSurface = Color(0xFFFFF8E6);

  // ── Semántico Informativo ────────────────────────────────────────────────
  static const info = Color(0xFF2F80ED);
  static const infoSurface = Color(0xFFE5F0FF);
}
