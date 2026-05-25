import 'package:flutter/material.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';

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
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    if (index == 2) {
      const SchoolsRoute().push<void>(context);
    }
  }

  void _goToProfile() {
    // TODO: Navigator.push → ProfileScreen
  }

  void _goToRegisterPlayer() {
    // TODO: Navigator.push → RegisterPlayerScreen
  }

  void _goToRegisterSchool() {
    const SchoolsRoute().push<void>(context);
  }

  void _goToNewVisoria() {
    // TODO: Navigator.push → NewVisoriaScreen
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
            onAvatarTap: _goToProfile,
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
