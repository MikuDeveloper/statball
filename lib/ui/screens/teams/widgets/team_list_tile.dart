import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/enums.dart' show TeamGender;
import 'package:statball/app/global/constants.dart' show defaultRadius;
import 'package:statball/app/providers/global/teams_provider.dart';
import 'package:statball/domain/index.dart' show Team;
import 'package:statball/infrastructure/index.dart' show TeamApiException;
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ─── TeamListTile ────────────────────────────────────────────────────────────
class TeamListTile extends ConsumerWidget with SnackbarsMixin {
  final Team team;
  final String? schoolName;
  TeamListTile({super.key, required this.team, this.schoolName});

  Color get _genderColor => switch (team.gender) {
    TeamGender.masculino => AppColors.accentDark,
    TeamGender.femenino => AppColors.accentAlt,
    TeamGender.mixto => AppColors.warning,
  };

  Color get _genderSurface => switch (team.gender) {
    TeamGender.masculino => AppColors.accentSurface,
    TeamGender.femenino => AppColors.accentAltSurface,
    TeamGender.mixto => AppColors.warningSurface,
  };

  IconData get _genderIcon => switch (team.gender) {
    TeamGender.masculino => Icons.male_rounded,
    TeamGender.femenino => Icons.female_rounded,
    TeamGender.mixto => Icons.transgender_rounded,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(defaultRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultRadius),
        onTap: team.id == null
            ? null
            : () => TeamFormRoute(id: team.id).push<void>(context),
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
                decoration: BoxDecoration(
                  color: _genderSurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(_genderIcon, color: _genderColor),
              ),
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
                            team.name,
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
                        _CategoryChip(label: team.category),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_rounded,
                          size: 12,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            schoolName ?? 'Escuela desconocida',
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
                          Icons.sports_rounded,
                          size: 12,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            team.coachName.isEmpty
                                ? 'Sin entrenador'
                                : team.coachName,
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
                onPressed: team.id == null
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
        title: const Text('Eliminar equipo'),
        content: Text(
          '¿Seguro que quieres eliminar “${team.name}”? '
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

    if (confirmed != true || team.id == null) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref.read(teamsProvider.notifier).remove(team.id!);
      messenger.showSnackBar(successSnackBar(message: 'Equipo eliminado'));
    } on TeamApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo eliminar el equipo'),
      );
    }
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Text(
        label,
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
