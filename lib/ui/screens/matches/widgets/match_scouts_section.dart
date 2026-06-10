import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultRadius;
import 'package:statball/app/providers/forms/scout_match_form_provider.dart';
import 'package:statball/app/providers/global/sb_user_data_provider.dart';
import 'package:statball/app/providers/global/scout_matches_provider.dart';
import 'package:statball/app/providers/global/scouts_provider.dart';
// Sin `show` para que ScoutX.displayName entre en scope.
import 'package:statball/domain/index.dart';
import 'package:statball/infrastructure/index.dart' show ScoutMatchApiException;
import 'package:statball/ui/common/forms/sb_field_label.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ════════════════════════════════════════════════════════════════════════════
//  MATCH SCOUTS SECTION — lista de scouts asignados a un partido + alta/baja.
//  Vive dentro del form de partido (modo edición). Las asignaciones son CRUD
//  inmediato sobre scouts_matches (no esperan al "guardar" del partido).
// ════════════════════════════════════════════════════════════════════════════
class MatchScoutsSection extends ConsumerWidget {
  final int matchId;
  const MatchScoutsSection({super.key, required this.matchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAssignments = ref.watch(scoutMatchesProvider(matchId));
    final asyncScouts = ref.watch(scoutsProvider);
    final role = ref.watch(sbUserDataProvider).value?.role ?? '';
    final isSuperScout = role == 'super_scout';

    return asyncAssignments.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: AppColors.accentDark,
            ),
          ),
        ),
      ),
      error: (e, _) => _ErrorBox(
        message: e.toString(),
        onRetry: () => ref.invalidate(scoutMatchesProvider(matchId)),
      ),
      data: (assignments) {
        // Index de scouts para resolver nombre en O(1).
        final scouts = asyncScouts.value ?? const <Scout>[];
        final scoutById = {for (final s in scouts) s.id: s};

        // Título dinámico según rol.
        final title = isSuperScout
            ? 'Scouts asignados (${assignments.length})'
            : 'Mi asignación';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 10),

            if (assignments.isEmpty)
              isSuperScout
                  ? const _EmptyHint()
                  : const _ScoutNoAssignmentHint()
            else
              ...assignments.map(
                (a) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _AssignmentTile(
                    assignment: a,
                    scout: scoutById[a.scoutId],
                    matchId: matchId,
                    isSuperScout: isSuperScout,
                  ),
                ),
              ),

            if (isSuperScout) ...[
              const SizedBox(height: 4),
              OutlinedButton.icon(
                onPressed: () => _openAssignSheet(context, ref, scouts),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.accentDark,
                  side: const BorderSide(color: AppColors.accentDark),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.person_add_alt_1_rounded, size: 18),
                label: const Text(
                  'Asignar scout',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Future<void> _openAssignSheet(
    BuildContext context,
    WidgetRef ref,
    List<Scout> allScouts,
  ) async {
    // Filtra scouts ya asignados para evitar duplicados (no hay unique en DB).
    final assignedIds = ref
        .read(scoutMatchesProvider(matchId).notifier)
        .assignedScoutIds;
    final available = allScouts
        .where((s) => s.id != null && !assignedIds.contains(s.id))
        .toList();

    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay más scouts disponibles para asignar'),
        ),
      );
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AssignScoutSheet(matchId: matchId, scouts: available),
    );
  }
}

// ─── _AssignmentTile ────────────────────────────────────────────────────────
class _AssignmentTile extends ConsumerWidget with SnackbarsMixin {
  final ScoutMatch assignment;
  final Scout? scout;
  final int matchId;
  final bool isSuperScout;
  _AssignmentTile({
    required this.assignment,
    required this.scout,
    required this.matchId,
    required this.isSuperScout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = scout?.displayName ?? 'Scout desconocido';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(defaultRadius),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppColors.warningSurface,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.assignment_ind_rounded,
              size: 20,
              color: AppColors.warning,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (assignment.notes.trim().isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    assignment.notes,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isSuperScout)
            IconButton(
              tooltip: 'Quitar asignación',
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.error,
                size: 20,
              ),
              onPressed: assignment.id == null
                  ? null
                  : () => _confirmRemove(context, ref),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmRemove(BuildContext context, WidgetRef ref) async {
    final name = scout?.displayName ?? 'este scout';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text('Quitar asignación'),
        content: Text('¿Quitar a “$name” de este partido?'),
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
            child: const Text('Quitar'),
          ),
        ],
      ),
    );

    if (confirmed != true || assignment.id == null) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref
          .read(scoutMatchesProvider(matchId).notifier)
          .remove(assignment.id!);
      messenger.showSnackBar(successSnackBar(message: 'Asignación quitada'));
    } on ScoutMatchApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo quitar la asignación'),
      );
    }
  }
}

// ─── _AssignScoutSheet ──────────────────────────────────────────────────────
class _AssignScoutSheet extends ConsumerStatefulWidget {
  final int matchId;
  final List<Scout> scouts;
  const _AssignScoutSheet({required this.matchId, required this.scouts});

  @override
  ConsumerState<_AssignScoutSheet> createState() => _AssignScoutSheetState();
}

class _AssignScoutSheetState extends ConsumerState<_AssignScoutSheet>
    with SnackbarsMixin {
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(scoutMatchFormProvider).form.reset();
    });
  }

  Future<void> _assign() async {
    final form = ref.read(scoutMatchFormProvider).form;
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }
    setState(() => _saving = true);
    final values = form.value;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      await ref
          .read(scoutMatchesProvider(widget.matchId).notifier)
          .assign(
            scoutId: values['scoutId'] as String,
            notes: (values['notes'] as String? ?? '').trim(),
          );
      navigator.pop();
      messenger.showSnackBar(successSnackBar(message: 'Scout asignado'));
    } on ScoutMatchApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo asignar el scout'),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(scoutMatchFormProvider).form;
    // Padding inferior para no quedar tapado por el teclado.
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Asignar scout al partido',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 18),

            const SbFieldLabel(text: 'SCOUT *'),
            const SizedBox(height: 6),
            ReactiveDropdownField<String>(
              formControlName: 'scoutId',
              isExpanded: true,
              hint: const Text(
                'Selecciona un scout',
                style: TextStyle(color: AppColors.textMuted),
              ),
              decoration: _sheetDecoration('Selecciona un scout'),
              items: widget.scouts
                  .map(
                    (s) => DropdownMenuItem<String>(
                      value: s.id,
                      child: Text(
                        s.displayName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                    ),
                  )
                  .toList(),
              validationMessages: {
                ValidationMessage.required: (_) => 'Requerido',
              },
            ),
            const SizedBox(height: 14),

            const SbFieldLabel(text: 'NOTAS'),
            const SizedBox(height: 6),
            ReactiveTextField<String>(
              formControlName: 'notes',
              minLines: 2,
              maxLines: 3,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _sheetDecoration(
                'Ej. enfocarse en el mediocampo, llegó tarde...',
              ),
            ),
            const SizedBox(height: 20),

            ReactiveFormConsumer(
              builder: (_, fg, _) {
                final enabled = fg.valid && !_saving;
                return SizedBox(
                  height: 50,
                  child: FilledButton(
                    onPressed: enabled ? _assign : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.accentDark,
                      foregroundColor: AppColors.onAccent,
                      disabledBackgroundColor: AppColors.bgDisabled,
                      disabledForegroundColor: AppColors.textDisabled,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: _saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.onAccent,
                            ),
                          )
                        : const Text(
                            'Asignar',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration _sheetDecoration(String hint) => InputDecoration(
  hintText: hint,
  hintStyle: const TextStyle(color: AppColors.textMuted),
  filled: true,
  fillColor: AppColors.card,
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.cardBorder),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.cardBorder),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.accentDark, width: 1.4),
  ),
);

// ─── helpers de estado ──────────────────────────────────────────────────────

// Empty state para scout sin asignación en el partido.
class _ScoutNoAssignmentHint extends StatelessWidget {
  const _ScoutNoAssignmentHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.assignment_ind_outlined,
            color: AppColors.textMuted,
            size: 18,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'No tienes asignación en este partido.',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.textMuted,
            size: 18,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Aún no hay scouts asignados a este partido.',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorBox({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.error,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.5,
              ),
            ),
          ),
          TextButton(onPressed: onRetry, child: const Text('Reintentar')),
        ],
      ),
    );
  }
}
