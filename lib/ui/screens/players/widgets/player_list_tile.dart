import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultRadius;
import 'package:statball/app/global/enums.dart' show FootPreference;
import 'package:statball/app/providers/global/players_provider.dart';
import 'package:statball/domain/index.dart' show Player;
import 'package:statball/infrastructure/index.dart' show PlayerApiException;
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ─── PlayerListTile ─────────────────────────────────────────────────────────
class PlayerListTile extends ConsumerWidget with SnackbarsMixin {
  final Player player;
  final String? teamName;
  PlayerListTile({super.key, required this.player, this.teamName});

  String get _initials {
    final f = player.firstname.trim();
    final l = player.lastname.trim();
    final fi = f.isNotEmpty ? f.characters.first.toUpperCase() : '';
    final li = l.isNotEmpty ? l.characters.first.toUpperCase() : '';
    final out = '$fi$li';
    return out.isEmpty ? '?' : out;
  }

  IconData get _footIcon => switch (player.preferredFoot) {
    FootPreference.izquierda => Icons.arrow_back_rounded,
    FootPreference.derecha => Icons.arrow_forward_rounded,
    FootPreference.ambidiestro => Icons.swap_horiz_rounded,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(defaultRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultRadius),
        onTap: player.id == null
            ? null
            : () => PlayerFormRoute(id: player.id).push<void>(context),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              _Avatar(player: player, fallbackInitials: _initials),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            player.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        // El chip de edad solo aparece si hay birthday registrado
                        if (player.age != null) ...[
                          const SizedBox(width: 8),
                          _AgeChip(age: player.age!),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.groups_rounded,
                          size: 12,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            teamName ?? 'Sin equipo',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(_footIcon, size: 12, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          player.preferredFoot.label,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (player.basicForces) ...[
                          const Icon(
                            Icons.fitness_center_rounded,
                            size: 12,
                            color: AppColors.accentAlt,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Fuerzas básicas',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.accentAlt,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Eliminar',
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.error,
                ),
                onPressed: player.id == null
                    ? null
                    : () => _confirmDelete(context, ref),
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
        title: const Text('Eliminar jugador'),
        content: Text(
          '¿Seguro que quieres eliminar a “${player.fullName}”? '
          'Esta acción no se puede deshacer.',
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

    if (confirmed != true || player.id == null) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref.read(playersProvider.notifier).remove(player.id!);
      messenger.showSnackBar(successSnackBar(message: 'Jugador eliminado'));
    } on PlayerApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo eliminar el jugador'),
      );
    }
  }
}

// Avatar: si hay URL de photo, intenta cargarla; cae a iniciales si falla,
// si no hay foto o si el valor es null/empty.
class _Avatar extends StatelessWidget {
  final Player player;
  final String fallbackInitials;
  const _Avatar({required this.player, required this.fallbackInitials});

  @override
  Widget build(BuildContext context) {
    final photoUrl = player.photo?.trim() ?? '';
    final hasPhoto = photoUrl.isNotEmpty;
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: AppColors.accentSurface,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: hasPhoto
          ? Image.network(
              photoUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _initialsFallback(),
              loadingBuilder: (_, child, progress) =>
                  progress == null ? child : _initialsFallback(),
            )
          : _initialsFallback(),
    );
  }

  Widget _initialsFallback() => Center(
    child: Text(
      fallbackInitials,
      style: const TextStyle(
        color: AppColors.accentDark,
        fontWeight: FontWeight.w800,
        fontSize: 14,
        letterSpacing: 0.4,
      ),
    ),
  );
}

class _AgeChip extends StatelessWidget {
  final int age;
  const _AgeChip({required this.age});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Text(
        '$age años',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
