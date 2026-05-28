import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultRadius;
import 'package:statball/app/providers/global/game_matches_provider.dart';
// Sin `show` para que GameMatchX.relativeLabel/isUpcoming estén en scope.
import 'package:statball/domain/index.dart';
import 'package:statball/infrastructure/index.dart' show GameMatchApiException;
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ─── GameMatchListTile ──────────────────────────────────────────────────────
// Tap → editar; papelera → confirmar y eliminar.
class GameMatchListTile extends ConsumerWidget with SnackbarsMixin {
  final GameMatch match;
  final Team? local;
  final Team? visitor;
  GameMatchListTile({
    super.key,
    required this.match,
    required this.local,
    required this.visitor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingColor = match.isUpcoming
        ? AppColors.accentDark
        : AppColors.textMuted;
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(defaultRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultRadius),
        onTap: match.id == null
            ? null
            : () => GameMatchFormRoute(id: match.id).push<void>(context),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    match.isUpcoming
                        ? Icons.event_rounded
                        : Icons.history_rounded,
                    size: 14,
                    color: upcomingColor,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      match.relativeLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: upcomingColor,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Eliminar',
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      size: 20,
                      color: AppColors.error,
                    ),
                    onPressed: match.id == null
                        ? null
                        : () => _confirmDelete(context, ref),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: _TeamSide(team: local, isLocal: true)),
                  const SizedBox(width: 10),
                  const Text(
                    'vs',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textMuted,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: _TeamSide(team: visitor, isLocal: false)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text('Eliminar partido'),
        content: Text(
          '¿Seguro que quieres eliminar este partido del '
          '${match.relativeLabel}? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != true || match.id == null) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref.read(gameMatchesProvider.notifier).remove(match.id!);
      messenger.showSnackBar(successSnackBar(message: 'Partido eliminado'));
    } on GameMatchApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo eliminar el partido'),
      );
    }
  }
}

// Lado de un equipo en el tile (nombre + categoría + label "LOCAL"/"VISIT").
class _TeamSide extends StatelessWidget {
  final Team? team;
  final bool isLocal;
  const _TeamSide({required this.team, required this.isLocal});

  @override
  Widget build(BuildContext context) {
    final label = isLocal ? 'LOCAL' : 'VISIT';
    final labelColor = isLocal ? AppColors.accentDark : AppColors.accentAlt;
    return Column(
      crossAxisAlignment: isLocal
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            color: labelColor,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          team?.name ?? 'Equipo desconocido',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: isLocal ? TextAlign.start : TextAlign.end,
          style: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.2,
          ),
        ),
        if (team?.category.isNotEmpty == true) ...[
          const SizedBox(height: 1),
          Text(
            team!.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: isLocal ? TextAlign.start : TextAlign.end,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ],
    );
  }
}
