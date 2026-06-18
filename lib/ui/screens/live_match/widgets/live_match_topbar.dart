import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/global/game_matches_provider.dart';
import 'package:statball/app/providers/global/live_match_provider.dart';
import 'package:statball/app/providers/global/teams_provider.dart';

// ─── LiveMatchTopBar ─────────────────────────────────────────────────────────
class LiveMatchTopBar extends ConsumerWidget {
  const LiveMatchTopBar({super.key, required this.matchId});

  final int matchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final match = ref.watch(
      gameMatchesProvider.select(
        (s) => s.value?.where((m) => m.id == matchId).firstOrNull,
      ),
    );
    final teams = ref.watch(teamsProvider).value ?? const [];
    final liveState = ref.watch(liveMatchProvider(matchId));

    String localName = 'Local';
    String visitorName = 'Visitante';
    if (match != null) {
      for (final t in teams) {
        if (t.id == match.localTeamId) localName = t.name;
        if (t.id == match.visitorTeamId) visitorName = t.name;
      }
    }

    return Container(
      color: AppColors.card,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 8,
        left: 8,
        right: 12,
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
          ),

          // Títulos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Partido en vivo',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  '$localName vs $visitorName',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Cronómetro
          _ClockWidget(
            matchId: matchId,
            minute: liveState.currentMinute,
            running: liveState.clockRunning,
          ),

          const SizedBox(width: 12),

          // Botón Finalizar (stub 9d)
          OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Disponible en deliverable 9d')),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Finalizar partido',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── _ClockWidget ─────────────────────────────────────────────────────────────
class _ClockWidget extends ConsumerWidget {
  const _ClockWidget({
    required this.matchId,
    required this.minute,
    required this.running,
  });

  final int matchId;
  final int minute;
  final bool running;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showClockDialog(context, ref),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: running ? AppColors.accentSurface : AppColors.bgLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: running ? AppColors.accentDark : AppColors.cardBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              running ? Icons.timer_rounded : Icons.timer_outlined,
              size: 14,
              color: running ? AppColors.accentDark : AppColors.textMuted,
            ),
            const SizedBox(width: 4),
            Text(
              "$minute'",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: running ? AppColors.accentDark : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClockDialog(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(liveMatchProvider(matchId).notifier);
    final controller = TextEditingController(text: minute.toString());

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text(
          'Cronómetro',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Minuto actual',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ClockBtn(
                  label: running ? 'Pausar' : 'Iniciar',
                  icon: running
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: AppColors.accentDark,
                  onTap: () {
                    if (running) {
                      notifier.pauseClock();
                    } else {
                      notifier.startClock();
                    }
                    Navigator.of(ctx).pop();
                  },
                ),
                _ClockBtn(
                  label: 'Resetear',
                  icon: Icons.restart_alt_rounded,
                  color: AppColors.textMuted,
                  onTap: () {
                    notifier.resetClock();
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.accentDark,
              foregroundColor: AppColors.onAccent,
            ),
            onPressed: () {
              final val = int.tryParse(controller.text);
              if (val != null && val >= 0) notifier.setMinute(val);
              Navigator.of(ctx).pop();
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }
}

class _ClockBtn extends StatelessWidget {
  const _ClockBtn({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }
}
