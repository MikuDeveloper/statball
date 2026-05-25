import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultRadius;
import 'package:statball/app/providers/global/schools_provider.dart';
import 'package:statball/domain/index.dart' show School;
import 'package:statball/infrastructure/index.dart' show SchoolApiException;
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ─── SchoolListTile ─────────────────────────────────────────────────────────
// Tap → editar; botón papelera → confirmar y eliminar.
class SchoolListTile extends ConsumerWidget with SnackbarsMixin {
  final School school;
  SchoolListTile({super.key, required this.school});

  String get _location {
    final parts = [
      school.city,
      school.state,
      school.country,
    ].whereType<String>().where((p) => p.isNotEmpty).toList();
    return parts.isEmpty ? 'Sin ubicación' : parts.join(', ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(defaultRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultRadius),
        onTap: school.id == null
            ? null
            : () => SchoolFormRoute(id: school.id).push<void>(context),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.accentSurface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_rounded,
                  color: AppColors.accentDark,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      school.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(
                          Icons.place_rounded,
                          size: 13,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.5,
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
                onPressed: school.id == null
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
        title: const Text('Eliminar escuela'),
        content: Text(
          '¿Seguro que quieres eliminar “${school.name}”? '
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

    if (confirmed != true || school.id == null) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref.read(schoolsProvider.notifier).remove(school.id!);
      messenger.showSnackBar(successSnackBar(message: 'Escuela eliminada'));
    } on SchoolApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo eliminar la escuela'),
      );
    }
  }
}
