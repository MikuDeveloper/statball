import 'package:flutter/material.dart';
import 'package:statball/app/config/themes/app_colors.dart';

// ════════════════════════════════════════════════════════════════════════════
//  SB WIDGETS — biblioteca de widgets reutilizables (pantallas internas)
//
//  Índice:
//    · SbScaffold          Base scaffold con fondo claro
//    · SbSectionTitle      Encabezado de sección
//    · SbCard              Contenedor tarjeta blanca
//    · SbSummaryCard       Métrica destacada (número + etiqueta)
//    · SbActionButton      Botón de acción rápida (ícono + label)
//    · SbVisoriaActiveCard Tarjeta oscura "visoria en curso"
//    · SbPlayerCard        Fila de jugador destacado
//    · SbFeedItem          Entrada del feed de actividad reciente
//    · SbTopBar            Barra superior del scout
//    · SbBottomNav         Navegación inferior (4 ítems)
//    · SbAvatarInitials    Avatar circular con iniciales
//    · SbChip              Chip etiqueta de estado
// ════════════════════════════════════════════════════════════════════════════

// ─── SbScaffold ─────────────────────────────────────────────────────────────
/// Scaffold base para todas las pantallas internas de la app.
class SbScaffold extends StatelessWidget {
  final Widget body;
  final int currentNavIndex;
  final ValueChanged<int> onNavTap;

  const SbScaffold({
    super.key,
    required this.body,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: body,
      bottomNavigationBar: SbBottomNav(
        currentIndex: currentNavIndex,
        onTap: onNavTap,
      ),
    );
  }
}

// ─── SbSectionTitle ─────────────────────────────────────────────────────────
/// Etiqueta de sección en mayúsculas con espaciado de letras.
class SbSectionTitle extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  const SbSectionTitle({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.textMuted,
            letterSpacing: 0.9,
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionLabel!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accentDark,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── SbCard ─────────────────────────────────────────────────────────────────
/// Contenedor tarjeta blanca estándar con borde sutil.
class SbCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? color;
  final VoidCallback? onTap;

  const SbCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(14);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? AppColors.card,
          borderRadius: radius,
          border: Border.all(color: AppColors.cardBorder, width: 0.8),
        ),
        padding: padding ?? const EdgeInsets.all(14),
        child: child,
      ),
    );
  }
}

// ─── SbSummaryCard ──────────────────────────────────────────────────────────
/// Tarjeta de métrica: valor numérico grande + etiqueta descriptiva.
class SbSummaryCard extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const SbSummaryCard({
    super.key,
    required this.value,
    required this.label,
    this.valueColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return SbCard(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: valueColor,
              height: 1.0,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              color: AppColors.textMuted,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── SbActionButton ─────────────────────────────────────────────────────────
/// Botón de acción rápida: ícono coloreado + etiqueta + fondo blanco.
class SbActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color iconBackground;
  final VoidCallback? onTap;

  const SbActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.iconBackground,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SbCard(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── SbVisoriaActiveCard ─────────────────────────────────────────────────────
/// Tarjeta oscura que muestra una visoria en curso con indicador "En vivo".
class SbVisoriaActiveCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const SbVisoriaActiveCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Dot pulsante (simplificado sin animación — añade TweenAnimationBuilder si deseas)
            Container(
              width: 9,
              height: 9,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF0F0F5),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF5A5A72),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Chip "En vivo"
            SbChip(
              label: 'En vivo',
              textColor: AppColors.accentDark,
              backgroundColor: AppColors.accent.withValues(alpha: 0.12),
              borderColor: AppColors.accent.withValues(alpha: 0.25),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── SbPlayerCard ───────────────────────────────────────────────────────────
/// Tarjeta horizontal de jugador con avatar, info y estadísticas clave.
class SbPlayerCard extends StatelessWidget {
  final String name;
  final String position;
  final int age;
  final Map<String, String> stats; // ej. {'Goles': '14', 'Asist.': '9'}
  final Color avatarColor;
  final Color avatarTextColor;
  final VoidCallback? onTap;

  const SbPlayerCard({
    super.key,
    required this.name,
    required this.position,
    required this.age,
    required this.stats,
    this.avatarColor = AppColors.accentSurface,
    this.avatarTextColor = AppColors.accentDark,
    this.onTap,
  });

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return parts[0].substring(0, 2);
  }

  @override
  Widget build(BuildContext context) {
    return SbCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          // Avatar
          SbAvatarInitials(
            initials: _initials,
            backgroundColor: avatarColor,
            textColor: avatarTextColor,
            size: 38,
          ),
          const SizedBox(width: 12),

          // Nombre + posición
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$position · $age años',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // Stats
          Row(
            children: stats.entries.map((e) {
              return Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  children: [
                    Text(
                      e.value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      e.key,
                      style: const TextStyle(
                        fontSize: 9.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(width: 10),

          // Estrella favorito
          const Icon(Icons.star_rounded, color: AppColors.warning, size: 17),
        ],
      ),
    );
  }
}

// ─── SbFeedItem ─────────────────────────────────────────────────────────────
/// Entrada individual del feed de actividad reciente.
class SbFeedItem extends StatelessWidget {
  final String text; // puede incluir porciones en negrita (ver RichText)
  final String timeAgo;
  final Color dotColor;
  final bool isLast;

  const SbFeedItem({
    super.key,
    required this.text,
    required this.timeAgo,
    this.dotColor = AppColors.accentDark,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.divider, width: 0.8),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot indicador
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Texto
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Tiempo
          Text(
            timeAgo,
            style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

// ─── SbTopBar ───────────────────────────────────────────────────────────────
/// Barra superior del scout: saludo + avatar navegable al perfil.
class SbTopBar extends StatelessWidget {
  final String scoutName;
  final String dateLine;
  final VoidCallback? onAvatarTap;

  const SbTopBar({
    super.key,
    required this.scoutName,
    required this.dateLine,
    this.onAvatarTap,
  });

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Buenos días';
    if (hour < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  String get _initials {
    final parts = scoutName.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return parts[0].substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.card,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 14,
        bottom: 14,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila principal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Saludo
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_greeting 👋',
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: scoutName.split(' ').first,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: ' ${scoutName.split(' ').skip(1).join(' ')}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.accentDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Avatar → Perfil
              GestureDetector(
                onTap: onAvatarTap,
                child: SbAvatarInitials(
                  initials: _initials,
                  backgroundColor: AppColors.accentAltSurface,
                  textColor: AppColors.accentAlt,
                  size: 42,
                ),
              ),
            ],
          ),

          const SizedBox(height: 11),

          // Pill de fecha / temporada
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accentSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.accentBorder, width: 0.8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 12,
                  color: AppColors.accentDark,
                ),
                const SizedBox(width: 6),
                Text(
                  dateLine,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── SbBottomNav ────────────────────────────────────────────────────────────
/// Navegación inferior con 4 destinos (sin perfil — va en el TopBar).
class SbBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const SbBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Inicio',
    ),
    _NavItem(
      icon: Icons.people_outline,
      activeIcon: Icons.people_rounded,
      label: 'Jugadores',
    ),
    _NavItem(
      icon: Icons.account_balance_outlined,
      activeIcon: Icons.account_balance_rounded,
      label: 'Escuelas',
    ),
    _NavItem(
      // FASE 2: wireado a /matches. Las estadísticas vendrán en FASE 3 y
      // este item se podrá mover o duplicar.
      icon: Icons.sports_soccer_outlined,
      activeIcon: Icons.sports_soccer_rounded,
      label: 'Partidos',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(
          top: BorderSide(color: AppColors.cardBorder, width: 0.8),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 4,
        top: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          final isActive = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isActive ? item.activeIcon : item.icon,
                    size: 24,
                    color: isActive
                        ? AppColors.textPrimary
                        : AppColors.textMuted,
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                      color: isActive
                          ? AppColors.textPrimary
                          : AppColors.textMuted,
                    ),
                    child: Text(item.label),
                  ),
                  const SizedBox(height: 2),
                  // Dot indicador
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: isActive ? 4 : 0,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.textPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Modelo de ítem de navegación (privado).
class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

// ─── SbAvatarInitials ───────────────────────────────────────────────────────
/// Círculo con iniciales de texto. Completamente reutilizable.
class SbAvatarInitials extends StatelessWidget {
  final String initials;
  final Color backgroundColor;
  final Color textColor;
  final double size;

  const SbAvatarInitials({
    super.key,
    required this.initials,
    required this.backgroundColor,
    required this.textColor,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initials.toUpperCase(),
        style: TextStyle(
          fontSize: size * 0.32,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─── SbChip ─────────────────────────────────────────────────────────────────
/// Chip de estado / etiqueta coloreada.
class SbChip extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final Color? borderColor;
  final IconData? icon;

  const SbChip({
    super.key,
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    this.borderColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 0.8)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 11, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
