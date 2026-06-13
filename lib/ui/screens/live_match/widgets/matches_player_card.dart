import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/enums.dart' show EvaluationStatus;
import 'package:statball/domain/models/matches_player/matches_player.dart';

import 'player_options_menu.dart';

// ─── MatchesPlayerCard ───────────────────────────────────────────────────────
// Tarjeta del sidebar que muestra un jugador asignado al partido.
// El borde izquierdo cambia de color según el estado de evaluación.
class MatchesPlayerCard extends ConsumerWidget {
  const MatchesPlayerCard({
    super.key,
    required this.player,
    required this.playerName,
    required this.eventCount,
    required this.isSelected,
    required this.matchId,
    required this.onTap,
  });

  final MatchesPlayer player;
  final String playerName;
  final int eventCount;
  final bool isSelected;
  final int matchId;
  final VoidCallback onTap;

  Color get _statusBorder => switch (player.evaluationStatus) {
    EvaluationStatus.enEvaluacion => AppColors.accentDark,
    EvaluationStatus.salioDeEvaluacion => AppColors.warning,
    EvaluationStatus.completada => AppColors.textMuted,
  };

  Color get _cardBg => isSelected ? AppColors.accentSurface : AppColors.card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(color: _statusBorder, width: 3),
            right: BorderSide(color: AppColors.cardBorder, width: 0.5),
            top: BorderSide(color: AppColors.cardBorder, width: 0.5),
            bottom: BorderSide(color: AppColors.cardBorder, width: 0.5),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    playerName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    player.position.label,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _StatusBadge(status: player.evaluationStatus),
                      const Spacer(),
                      Text(
                        '$eventCount ev.',
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Botón 3-puntos — usa Builder para capturar su RenderBox
            Builder(
              builder: (btnCtx) => GestureDetector(
                onTap: () => _onMenuTap(btnCtx, ref),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.more_vert_rounded,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMenuTap(BuildContext btnCtx, WidgetRef ref) {
    final box = btnCtx.findRenderObject() as RenderBox?;
    if (box == null) return;
    final offset = box.localToGlobal(Offset.zero);
    final size = box.size;
    final position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + size.height,
      offset.dx + size.width,
      0,
    );
    showPlayerOptionsMenu(
      context: btnCtx,
      ref: ref,
      player: player,
      matchId: matchId,
      position: position,
    );
  }
}

// ─── _StatusBadge ─────────────────────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final EvaluationStatus status;

  Color get _color => switch (status) {
    EvaluationStatus.enEvaluacion => AppColors.accentDark,
    EvaluationStatus.salioDeEvaluacion => AppColors.warning,
    EvaluationStatus.completada => AppColors.textMuted,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 8.5,
          fontWeight: FontWeight.w700,
          color: _color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
