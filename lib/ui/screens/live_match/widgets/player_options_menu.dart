import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/enums.dart' show EvaluationStatus;
import 'package:statball/app/providers/global/matches_players_provider.dart';
import 'package:statball/domain/models/matches_player/matches_player.dart';
import 'package:statball/infrastructure/helpers/exceptions/matches_player_api_exception.dart';

// ─── showPlayerOptionsMenu ────────────────────────────────────────────────────
// Muestra un popup menu desde la posición del botón de 3-puntos.
// El [position] se calcula con RelativeRect desde el RenderBox del botón.
Future<void> showPlayerOptionsMenu({
  required BuildContext context,
  required WidgetRef ref,
  required MatchesPlayer player,
  required int matchId,
  required RelativeRect position,
}) async {
  final option = await showMenu<_Option>(
    context: context,
    position: position,
    items: const [
      PopupMenuItem(
        value: _Option.evaluation,
        child: _MenuItem(
          icon: Icons.assessment_rounded,
          label: 'Ir a evaluación final',
          color: AppColors.textPrimary,
        ),
      ),
      PopupMenuItem(
        value: _Option.salio,
        child: _MenuItem(
          icon: Icons.directions_run_rounded,
          label: 'Salió de evaluación',
          color: AppColors.warning,
        ),
      ),
      PopupMenuItem(
        value: _Option.completada,
        child: _MenuItem(
          icon: Icons.check_circle_outline_rounded,
          label: 'Marcar completada',
          color: AppColors.accentDark,
        ),
      ),
      PopupMenuItem(
        value: _Option.remove,
        child: _MenuItem(
          icon: Icons.delete_outline_rounded,
          label: 'Remover del partido',
          color: AppColors.error,
        ),
      ),
    ],
  );

  if (!context.mounted || option == null) return;

  switch (option) {
    case _Option.evaluation:
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Disponible en deliverable 9b')),
      );

    case _Option.salio:
      await _changeStatus(
        context: context,
        ref: ref,
        player: player,
        matchId: matchId,
        status: EvaluationStatus.salioDeEvaluacion,
      );

    case _Option.completada:
      await _changeStatus(
        context: context,
        ref: ref,
        player: player,
        matchId: matchId,
        status: EvaluationStatus.completada,
      );

    case _Option.remove:
      await _removePlayer(
        context: context,
        ref: ref,
        player: player,
        matchId: matchId,
      );
  }
}

// ── Helpers privados ──────────────────────────────────────────────────────────

Future<void> _changeStatus({
  required BuildContext context,
  required WidgetRef ref,
  required MatchesPlayer player,
  required int matchId,
  required EvaluationStatus status,
}) async {
  if (player.id == null || !context.mounted) return;
  final messenger = ScaffoldMessenger.of(context);
  try {
    await ref
        .read(matchesPlayersProvider(matchId).notifier)
        .updateStatus(player.id!, status);
    messenger.showSnackBar(
      SnackBar(content: Text('Estado actualizado: ${status.label}')),
    );
  } on MatchesPlayerApiException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.message)));
  } catch (_) {
    messenger.showSnackBar(
      const SnackBar(content: Text('No se pudo actualizar el estado')),
    );
  }
}

Future<void> _removePlayer({
  required BuildContext context,
  required WidgetRef ref,
  required MatchesPlayer player,
  required int matchId,
}) async {
  if (player.id == null || !context.mounted) return;

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.card,
      title: const Text('Remover jugador'),
      content: const Text(
        '¿Remover este jugador del partido? Se perderán sus eventos registrados.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Remover'),
        ),
      ],
    ),
  );

  if (confirmed != true || !context.mounted) return;
  final messenger = ScaffoldMessenger.of(context);
  try {
    await ref.read(matchesPlayersProvider(matchId).notifier).remove(player.id!);
    messenger.showSnackBar(const SnackBar(content: Text('Jugador removido')));
  } on MatchesPlayerApiException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.message)));
  } catch (_) {
    messenger.showSnackBar(
      const SnackBar(content: Text('No se pudo remover el jugador')),
    );
  }
}

// ── Enums e items internos ────────────────────────────────────────────────────

enum _Option { evaluation, salio, completada, remove }

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Text(label, style: TextStyle(color: color, fontSize: 13.5)),
      ],
    );
  }
}
