import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultRadius;
import 'package:statball/app/providers/global/school_principals_provider.dart';
import 'package:statball/domain/index.dart' show SchoolPrincipal;
import 'package:statball/infrastructure/index.dart'
    show SchoolPrincipalApiException;
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ─── SchoolPrincipalListTile ────────────────────────────────────────────────
// Tap → editar; papelera → confirmar y eliminar (puede fallar si hay escuelas
// asociadas, lo cual se reporta via snackbar).
class SchoolPrincipalListTile extends ConsumerWidget with SnackbarsMixin {
  final SchoolPrincipal principal;
  SchoolPrincipalListTile({super.key, required this.principal});

  String get _initials {
    final f = principal.name.trim();
    final l = principal.lastname.trim();
    final fi = f.isNotEmpty ? f.characters.first.toUpperCase() : '';
    final li = l.isNotEmpty ? l.characters.first.toUpperCase() : '';
    final out = '$fi$li';
    return out.isEmpty ? '?' : out;
  }

  String get _subtitle {
    final e = principal.email?.trim();
    final p = principal.phoneNumber?.trim();
    if (e != null && e.isNotEmpty) return e;
    if (p != null && p.isNotEmpty) return p;
    return 'Sin contacto';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(defaultRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultRadius),
        onTap: principal.id == null
            ? null
            : () => SchoolPrincipalFormRoute(
                id: principal.id,
              ).push<void>(context),
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
                  color: AppColors.accentAltSurface,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  _initials,
                  style: const TextStyle(
                    color: AppColors.accentAlt,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      principal.displayName,
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
                    Text(
                      _subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textMuted,
                      ),
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
                onPressed: principal.id == null
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
        title: const Text('Eliminar director'),
        content: Text(
          '¿Seguro que quieres eliminar a “${principal.displayName}”? '
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

    if (confirmed != true || principal.id == null) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref.read(schoolPrincipalsProvider.notifier).remove(principal.id!);
      messenger.showSnackBar(successSnackBar(message: 'Director eliminado'));
    } on SchoolPrincipalApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo eliminar el director'),
      );
    }
  }
}
