import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/enums.dart' show EvaluationStatus;
import 'package:statball/app/providers/global/live_match_provider.dart';
import 'package:statball/app/providers/global/match_events_provider.dart';
import 'package:statball/app/providers/global/players_provider.dart';
import 'package:statball/domain/models/matches_player/matches_player.dart';

import 'matches_player_card.dart';

// ─── LiveMatchSidebar ────────────────────────────────────────────────────────
// Sidebar fijo 200px. Lista jugadores asignados al partido, con sección label
// "EN EVALUACIÓN (N)", tarjetas coloreadas por status y botón "Agregar jugador"
// (stub — disponible en deliverable 9c).
class LiveMatchSidebar extends ConsumerWidget {
  const LiveMatchSidebar({
    super.key,
    required this.matchId,
    required this.players,
  });

  final int matchId;
  final List<MatchesPlayer> players;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveState = ref.watch(liveMatchProvider(matchId));
    final allPlayers = ref.watch(playersProvider).value ?? const [];

    // Jugadores activos (en evaluación)
    final activeCount = players
        .where((p) => p.evaluationStatus == EvaluationStatus.enEvaluacion)
        .length;

    return Container(
      color: AppColors.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Sección label ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'EN EVALUACIÓN',
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentSurface,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '($activeCount)',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentDark,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.cardBorder),

          // ── Lista de jugadores ──────────────────────────────────────────
          Expanded(
            child: players.isEmpty
                ? const _EmptySidebar()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: players.length,
                    itemBuilder: (_, i) {
                      final mp = players[i];
                      final playerData = allPlayers
                          .where((p) => p.id == mp.playerId)
                          .firstOrNull;
                      final playerName =
                          playerData?.fullName ?? 'Jugador ${i + 1}';

                      // event count from cache (no re-fetch)
                      final eventCount = mp.id != null
                          ? ref
                                    .watch(matchEventsProvider(mp.id!))
                                    .value
                                    ?.length ??
                                0
                          : 0;

                      return MatchesPlayerCard(
                        player: mp,
                        playerName: playerName,
                        eventCount: eventCount,
                        isSelected: liveState.selectedPlayerId == mp.id,
                        matchId: matchId,
                        onTap: () {
                          if (mp.id != null) {
                            ref
                                .read(liveMatchProvider(matchId).notifier)
                                .selectPlayer(mp.id!);
                          }
                        },
                      );
                    },
                  ),
          ),

          // ── Botón Agregar jugador (stub 9c) ─────────────────────────────
          const Divider(height: 1, color: AppColors.cardBorder),
          Padding(
            padding: const EdgeInsets.all(8),
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Disponible en deliverable 9c')),
                );
              },
              icon: const Icon(Icons.add_rounded, size: 16),
              label: const Text(
                'Agregar jugador',
                style: TextStyle(fontSize: 12),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.accentDark,
                side: const BorderSide(color: AppColors.accentDark),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySidebar extends StatelessWidget {
  const _EmptySidebar();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          'Sin jugadores\nasignados',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),
      ),
    );
  }
}
