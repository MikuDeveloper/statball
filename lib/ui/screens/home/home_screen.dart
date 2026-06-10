import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/global/sb_user_data_provider.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

import 'widgets/sb_widgets.dart';

// ════════════════════════════════════════════════════════════════════════════
//  DASHBOARD SCREEN — pantalla principal del scout
//
//  Dependencias locales:
//    · app_colors.dart   → AppColors
//    · sb_widgets.dart   → SbScaffold, SbTopBar, SbSectionTitle, SbCard,
//                          SbSummaryCard, SbActionButton, SbVisoriaActiveCard,
//                          SbPlayerCard, SbFeedItem, SbChip
// ════════════════════════════════════════════════════════════════════════════
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SnackbarsMixin {
  int _navIndex = 0;

  // ── Datos de ejemplo (reemplazar con tu modelo/provider) ─────────────────
  static const _scoutName = 'Carlos Méndez';
  static const _dateLine = 'Viernes, 15 de mayo · Temporada 2025';
  static const _hasVisoria = true;

  final _summaryItems = const [
    _SummaryData('3', 'Jugadores\nregistrados hoy', AppColors.accentDark),
    _SummaryData('1', 'Visorias\nactivas', AppColors.accentAlt),
    _SummaryData('12', 'Total\njugadores', AppColors.textPrimary),
  ];

  final _players = const [
    _PlayerData(
      name: 'Andrés García',
      position: 'Mediocampista',
      age: 16,
      stats: {'Goles': '14', 'Asist.': '9'},
      avatarColor: AppColors.accentSurface,
      avatarTextColor: AppColors.accentDark,
    ),
    _PlayerData(
      name: 'Luis Ramírez',
      position: 'Delantero',
      age: 17,
      stats: {'Goles': '21', 'Asist.': '4'},
      avatarColor: AppColors.accentAltSurface,
      avatarTextColor: AppColors.accentAlt,
    ),
    _PlayerData(
      name: 'Marco Ortiz',
      position: 'Portero',
      age: 15,
      stats: {'Goles': '0', 'Atajadas': '18'},
      avatarColor: AppColors.warningSurface,
      avatarTextColor: AppColors.warning,
    ),
  ];

  final _feedItems = const [
    _FeedData(
      text: 'Andrés García fue registrado en Academia Morelia',
      timeAgo: 'Hace 20 min',
      dotColor: AppColors.accentDark,
    ),
    _FeedData(
      text: 'Se registró la escuela Fútbol Club Uruapan',
      timeAgo: 'Ayer',
      dotColor: AppColors.accentAlt,
    ),
    _FeedData(
      text: 'Visoria U-15 finalizada · 11 jugadores evaluados',
      timeAgo: 'Hace 2 días',
      dotColor: AppColors.warning,
    ),
  ];

  // ── Navegación ────────────────────────────────────────────────────────────
  // Índices del SbBottomNav: 0 Inicio, 1 Jugadores, 2 Escuelas, 3 Estadísticas
  void _onNavTap(int index) {
    setState(() => _navIndex = index);
    if (index == 1) {
      const PlayersRoute().push<void>(context);
    } else if (index == 2) {
      const SchoolsRoute().push<void>(context);
    } else if (index == 3) {
      // Item 3 antes era "Estadísticas" (placeholder). Lo wireamos a Partidos
      // hasta que FASE 3 traiga las stats; el label del SbBottomNav cambia
      // en paralelo a "Partidos".
      const MatchesRoute().push<void>(context);
    }
  }

  void _goToRegisterPlayer() {
    const PlayersRoute().push<void>(context);
  }

  void _goToRegisterSchool() {
    const SchoolsRoute().push<void>(context);
  }

  void _goToNewVisoria() {
    // Abre el form para programar un nuevo partido (visoría).
    const GameMatchFormRoute().push<void>(context);
  }

  void _goToActiveVisoria() {
    // TODO: Navigator.push → ActiveVisoriaScreen
  }

  void _goToAllPlayers() {
    // TODO: Navigator.push → PlayersScreen
  }

  void _goToPlayerDetail(_PlayerData player) {
    // TODO: Navigator.push → PlayerDetailScreen(player)
  }

  // ── Logout ────────────────────────────────────────────────────────────────
  void _openAvatarSheet() {
    final user = ref.read(sbUserDataProvider).value;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => _AvatarBottomSheet(
        email: user?.email ?? '',
        role: user?.role ?? '',
        onLogout: () => _confirmLogout(sheetCtx),
      ),
    );
  }

  void _confirmLogout(BuildContext sheetCtx) {
    showDialog<bool>(
      context: sheetCtx,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          '¿Cerrar sesión?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'Se cerrará tu sesión en este dispositivo.',
          style: TextStyle(color: AppColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: AppColors.textMuted),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed != true) return;
      _performLogout();
    });
  }

  Future<void> _performLogout() async {
    // Cerrar el bottom sheet antes de hacer logout
    if (mounted) Navigator.of(context).pop();

    try {
      await ref.read(sbUserDataProvider.notifier).logout();
      if (mounted) context.go('/login');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(message: 'Error al cerrar sesión. Intenta de nuevo.'),
        );
      }
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return SbScaffold(
      currentNavIndex: _navIndex,
      onNavTap: _onNavTap,
      body: Column(
        children: [
          // ── Top Bar (fuera del scroll para que quede fija) ──────────────
          SbTopBar(
            scoutName: _scoutName,
            dateLine: _dateLine,
            onAvatarTap: _openAvatarSheet,
          ),

          // ── Cuerpo scrolleable ──────────────────────────────────────────
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              children: [
                // ── 1. Resumen del día ──────────────────────────────────
                const SbSectionTitle(title: 'Tu actividad hoy'),
                const SizedBox(height: 10),
                _SummaryRow(items: _summaryItems),

                const SizedBox(height: 24),

                // ── 2. Acciones rápidas ─────────────────────────────────
                const SbSectionTitle(title: 'Acciones rápidas'),
                const SizedBox(height: 10),
                _QuickActionsRow(
                  onRegisterPlayer: _goToRegisterPlayer,
                  onRegisterSchool: _goToRegisterSchool,
                  onNewVisoria: _goToNewVisoria,
                ),

                // ── 3. Visoria en curso (condicional) ───────────────────
                if (_hasVisoria) ...[
                  const SizedBox(height: 24),
                  const SbSectionTitle(title: 'Visoria en curso'),
                  const SizedBox(height: 10),
                  SbVisoriaActiveCard(
                    title: 'Academia Morelia U-17',
                    subtitle: 'Iniciada hace 42 min · 8 jugadores evaluados',
                    onTap: _goToActiveVisoria,
                  ),
                ],

                const SizedBox(height: 24),

                // ── 4. Jugadores destacados ─────────────────────────────
                SbSectionTitle(
                  title: 'Jugadores destacados',
                  actionLabel: 'Ver todos',
                  onActionTap: _goToAllPlayers,
                ),
                const SizedBox(height: 10),
                _PlayersList(players: _players, onTap: _goToPlayerDetail),

                const SizedBox(height: 24),

                // ── 5. Actividad reciente ───────────────────────────────
                const SbSectionTitle(title: 'Actividad reciente'),
                const SizedBox(height: 10),
                _RecentFeed(items: _feedItems),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
//  AVATAR BOTTOM SHEET
// ════════════════════════════════════════════════════════════════════════════
class _AvatarBottomSheet extends StatelessWidget {
  final String email;
  final String role;
  final VoidCallback onLogout;

  const _AvatarBottomSheet({
    required this.email,
    required this.role,
    required this.onLogout,
  });

  String get _roleLabel {
    return switch (role) {
      'super_scout' => 'Super scout',
      _ => 'Scout',
    };
  }

  String get _initials {
    if (email.isEmpty) return '?';
    return email[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Handle ─────────────────────────────────────────────────────
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.cardBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Info del usuario ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.accentSurface,
                  child: Text(
                    _initials,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentDark,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        email.isEmpty ? 'Usuario' : email,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _roleLabel,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.divider),

          // ── Cerrar sesión ───────────────────────────────────────────────
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: AppColors.error),
            title: const Text(
              'Cerrar sesión',
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: onLogout,
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
//  SECCIONES PRIVADAS DEL DASHBOARD
//  Widgets de composición que agrupan la lógica de cada bloque visual.
// ════════════════════════════════════════════════════════════════════════════

// ─── _SummaryRow ─────────────────────────────────────────────────────────────
class _SummaryRow extends StatelessWidget {
  final List<_SummaryData> items;
  const _SummaryRow({required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: item != items.last ? 8 : 0),
            child: SbSummaryCard(
              value: item.value,
              label: item.label,
              valueColor: item.color,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── _QuickActionsRow ────────────────────────────────────────────────────────
class _QuickActionsRow extends StatelessWidget {
  final VoidCallback onRegisterPlayer;
  final VoidCallback onRegisterSchool;
  final VoidCallback onNewVisoria;

  const _QuickActionsRow({
    required this.onRegisterPlayer,
    required this.onRegisterSchool,
    required this.onNewVisoria,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SbActionButton(
            icon: Icons.person_add_alt_1_rounded,
            label: 'Registrar\njugador',
            iconColor: AppColors.accentDark,
            iconBackground: AppColors.accentSurface,
            onTap: onRegisterPlayer,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SbActionButton(
            icon: Icons.account_balance_rounded,
            label: 'Registrar\nescuela',
            iconColor: AppColors.accentAlt,
            iconBackground: AppColors.accentAltSurface,
            onTap: onRegisterSchool,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SbActionButton(
            icon: Icons.assignment_rounded,
            label: 'Nueva\nvisoria',
            iconColor: Colors.white,
            iconBackground: AppColors.bgLight,
            onTap: onNewVisoria,
          ),
        ),
      ],
    );
  }
}

// ─── _PlayersList ────────────────────────────────────────────────────────────
class _PlayersList extends StatelessWidget {
  final List<_PlayerData> players;
  final ValueChanged<_PlayerData> onTap;

  const _PlayersList({required this.players, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: players.map((p) {
        return Padding(
          padding: EdgeInsets.only(bottom: p != players.last ? 8 : 0),
          child: SbPlayerCard(
            name: p.name,
            position: p.position,
            age: p.age,
            stats: p.stats,
            avatarColor: p.avatarColor,
            avatarTextColor: p.avatarTextColor,
            onTap: () => onTap(p),
          ),
        );
      }).toList(),
    );
  }
}

// ─── _RecentFeed ─────────────────────────────────────────────────────────────
class _RecentFeed extends StatelessWidget {
  final List<_FeedData> items;
  const _RecentFeed({required this.items});

  @override
  Widget build(BuildContext context) {
    return SbCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return SbFeedItem(
            text: item.text,
            timeAgo: item.timeAgo,
            dotColor: item.dotColor,
            isLast: i == items.length - 1,
          );
        }),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
//  MODELOS DE DATOS LOCALES (simples, sin lógica de negocio)
//  Reemplazar por tus entidades / providers cuando corresponda.
// ════════════════════════════════════════════════════════════════════════════

class _SummaryData {
  final String value;
  final String label;
  final Color color;
  const _SummaryData(this.value, this.label, this.color);
}

class _PlayerData {
  final String name;
  final String position;
  final int age;
  final Map<String, String> stats;
  final Color avatarColor;
  final Color avatarTextColor;

  const _PlayerData({
    required this.name,
    required this.position,
    required this.age,
    required this.stats,
    required this.avatarColor,
    required this.avatarTextColor,
  });
}

class _FeedData {
  final String text;
  final String timeAgo;
  final Color dotColor;
  const _FeedData({
    required this.text,
    required this.timeAgo,
    required this.dotColor,
  });
}
