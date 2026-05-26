import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultRadius;
import 'package:statball/app/providers/global/scouts_provider.dart';
import 'package:statball/domain/index.dart' show Scout;
import 'package:statball/infrastructure/index.dart' show ScoutApiException;
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ─── ScoutListTile ──────────────────────────────────────────────────────────
class ScoutListTile extends ConsumerWidget with SnackbarsMixin {
  final Scout scout;
  ScoutListTile({super.key, required this.scout});

  String get _initials {
    final f = scout.name.trim();
    final l = scout.lastname.trim();
    final fi = f.isNotEmpty ? f.characters.first.toUpperCase() : '';
    final li = l.isNotEmpty ? l.characters.first.toUpperCase() : '';
    final out = '$fi$li';
    return out.isEmpty ? '?' : out;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(defaultRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultRadius),
        onTap: scout.id == null
            ? null
            : () => ScoutFormRoute(id: scout.id).push<void>(context),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              _Avatar(scout: scout, fallbackInitials: _initials),
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
                            scout.displayName,
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
                        const SizedBox(width: 8),
                        _AgeChip(age: scout.age),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone_rounded,
                          size: 12,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            scout.phoneNumber.isEmpty
                                ? 'Sin teléfono'
                                : scout.phoneNumber,
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
                        const Icon(
                          Icons.place_rounded,
                          size: 12,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            scout.address.isEmpty
                                ? 'Sin dirección'
                                : scout.address,
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
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Eliminar',
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.error,
                ),
                onPressed: scout.id == null
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
        title: const Text('Eliminar scout'),
        content: Text(
          '¿Seguro que quieres eliminar a “${scout.displayName}”? '
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

    if (confirmed != true || scout.id == null) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref.read(scoutsProvider.notifier).remove(scout.id!);
      messenger.showSnackBar(successSnackBar(message: 'Scout eliminado'));
    } on ScoutApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo eliminar el scout'),
      );
    }
  }
}

// Avatar circular: photo URL si está disponible, iniciales en caso contrario.
class _Avatar extends StatelessWidget {
  final Scout scout;
  final String fallbackInitials;
  const _Avatar({required this.scout, required this.fallbackInitials});

  @override
  Widget build(BuildContext context) {
    final photoUrl = scout.photo.trim();
    final hasPhoto = photoUrl.isNotEmpty;
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: AppColors.warningSurface,
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
        color: AppColors.warning,
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
