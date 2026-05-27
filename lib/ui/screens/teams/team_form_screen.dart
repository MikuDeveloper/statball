import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/enums.dart' show TeamGender;
import 'package:statball/app/providers/forms/team_form_provider.dart';
import 'package:statball/app/providers/global/schools_provider.dart';
import 'package:statball/app/providers/global/teams_provider.dart';
import 'package:statball/domain/index.dart' show School, Team;
import 'package:statball/infrastructure/index.dart' show TeamApiException;
import 'package:statball/ui/common/forms/sb_field_label.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ════════════════════════════════════════════════════════════════════════════
//  TEAM FORM SCREEN — pantalla completa para crear o editar un equipo.
//  Acepta `schoolId` opcional para pre-seleccionar la escuela cuando se llega
//  desde una pantalla con contexto (ej. listado filtrado por escuela).
// ════════════════════════════════════════════════════════════════════════════
class TeamFormScreen extends ConsumerStatefulWidget {
  final String? teamId;
  final int? presetSchoolId;
  const TeamFormScreen({super.key, this.teamId, this.presetSchoolId});

  @override
  ConsumerState<TeamFormScreen> createState() => _TeamFormScreenState();
}

class _TeamFormScreenState extends ConsumerState<TeamFormScreen>
    with SnackbarsMixin {
  bool _saving = false;
  Team? _existing;

  bool get _isEdit => widget.teamId != null;

  @override
  void initState() {
    super.initState();
    // Reset al entrar (no en dispose) para no notificar listeners en unmount.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(teamFormProvider).form.reset();
      _hydrate();
    });
  }

  void _hydrate() {
    final form = ref.read(teamFormProvider).form;
    if (_isEdit) {
      final team = ref.read(teamsProvider.notifier).byId(widget.teamId!);
      if (team == null) return;
      _existing = team;
      form.patchValue({
        'name': team.name,
        'category': team.category,
        'gender': team.gender,
        'coachName': team.coachName,
        'schoolId': team.schoolId,
      });
    } else if (widget.presetSchoolId != null) {
      // Modo creación: pre-cargamos la escuela si vino del contexto
      form.control('schoolId').value = widget.presetSchoolId;
    }
  }

  // El reset vive en initState (al entrar) para no notificar listeners en unmount.

  Future<void> _save() async {
    final form = ref.read(teamFormProvider).form;
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    setState(() => _saving = true);
    final values = form.value;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final team = Team(
      id: _existing?.id,
      name: (values['name'] as String).trim(),
      category: (values['category'] as String).trim(),
      gender: values['gender'] as TeamGender,
      coachName: (values['coachName'] as String).trim(),
      schoolId: values['schoolId'] as int,
    );

    try {
      final notifier = ref.read(teamsProvider.notifier);
      if (_isEdit) {
        await notifier.updateTeam(team);
        messenger.showSnackBar(successSnackBar(message: 'Equipo actualizado'));
      } else {
        await notifier.create(team);
        messenger.showSnackBar(successSnackBar(message: 'Equipo creado'));
      }
      form.reset();
      if (navigator.canPop()) navigator.pop();
    } on TeamApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo guardar el equipo'),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(teamFormProvider).form;
    final width = MediaQuery.of(context).size.width;
    final maxFormWidth = width > 720 ? 640.0 : double.infinity;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        surfaceTintColor: AppColors.bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          _isEdit ? 'Editar equipo' : 'Nuevo equipo',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxFormWidth),
            child: ReactiveForm(
              formGroup: form,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                children: [
                  const _SectionTitle('Datos del equipo'),
                  const SizedBox(height: 12),
                  const _LabeledField(
                    name: 'name',
                    label: 'NOMBRE *',
                    hint: 'Ej. Academia Morelia',
                  ),
                  const SizedBox(height: 12),
                  const _ResponsiveRow(
                    children: [
                      _LabeledField(
                        name: 'category',
                        label: 'CATEGORÍA *',
                        hint: 'Ej. U-17, Libre, Sub-15',
                      ),
                      _LabeledField(
                        name: 'coachName',
                        label: 'ENTRENADOR *',
                        hint: 'Nombre del entrenador',
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const SbFieldLabel(text: 'GÉNERO *'),
                  const SizedBox(height: 8),
                  const _GenderPicker(),
                  const SizedBox(height: 24),

                  const _SectionTitle('Escuela'),
                  const SizedBox(height: 12),
                  const _SchoolPicker(),
                  const SizedBox(height: 32),

                  ReactiveFormConsumer(
                    builder: (_, fg, _) {
                      final enabled = fg.valid && !_saving;
                      return SizedBox(
                        height: 52,
                        child: FilledButton(
                          onPressed: enabled ? _save : null,
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
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.onAccent,
                                  ),
                                )
                              : Text(
                                  _isEdit ? 'Guardar cambios' : 'Crear equipo',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Helpers de layout ──────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: AppColors.textMuted,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  const _ResponsiveRow({required this.children});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 600;
    if (!isWide) {
      return Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1) const SizedBox(height: 12),
          ],
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          Expanded(child: children[i]),
          if (i != children.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String name;
  final String label;
  final String hint;

  const _LabeledField({
    required this.name,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SbFieldLabel(text: label),
        const SizedBox(height: 6),
        ReactiveTextField<String>(
          formControlName: name,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _fieldDecoration(hint),
          validationMessages: {ValidationMessage.required: (_) => 'Requerido'},
        ),
      ],
    );
  }
}

InputDecoration _fieldDecoration(String hint) => InputDecoration(
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

// ─── _GenderPicker ──────────────────────────────────────────────────────────
// Segmented buttons: tap directo, sin dropdown. UX más rápida.
class _GenderPicker extends StatelessWidget {
  const _GenderPicker();

  @override
  Widget build(BuildContext context) {
    final control =
        (ReactiveForm.of(context) as FormGroup?)!.control('gender')
            as FormControl<TeamGender>;

    return StreamBuilder<TeamGender?>(
      stream: control.valueChanges,
      initialData: control.value,
      builder: (_, snapshot) {
        final current = snapshot.data;
        return Row(
          children: [
            for (final g in TeamGender.values) ...[
              Expanded(
                child: _GenderChip(
                  gender: g,
                  selected: current == g,
                  onTap: () => control.value = g,
                ),
              ),
              if (g != TeamGender.values.last) const SizedBox(width: 8),
            ],
          ],
        );
      },
    );
  }
}

class _GenderChip extends StatelessWidget {
  final TeamGender gender;
  final bool selected;
  final VoidCallback onTap;
  const _GenderChip({
    required this.gender,
    required this.selected,
    required this.onTap,
  });

  IconData get _icon => switch (gender) {
    TeamGender.masculino => Icons.male_rounded,
    TeamGender.femenino => Icons.female_rounded,
    TeamGender.mixto => Icons.transgender_rounded,
  };

  Color get _color => switch (gender) {
    TeamGender.masculino => AppColors.accentDark,
    TeamGender.femenino => AppColors.accentAlt,
    TeamGender.mixto => AppColors.warning,
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _color : AppColors.card,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? _color : AppColors.cardBorder,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _icon,
                color: selected ? AppColors.onAccent : _color,
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                gender.label,
                style: TextStyle(
                  color: selected ? AppColors.onAccent : AppColors.textPrimary,
                  fontSize: 12.5,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── _SchoolPicker ──────────────────────────────────────────────────────────
// Dropdown obligatorio + atajo para crear una nueva escuela sin perder el form.
class _SchoolPicker extends ConsumerWidget {
  const _SchoolPicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(schoolsProvider);
    final control =
        (ReactiveForm.of(context) as FormGroup?)!.control('schoolId')
            as FormControl<int>;

    return async.when(
      loading: () => const _PickerSkeleton(message: 'Cargando escuelas...'),
      error: (e, _) =>
          _PickerSkeleton(message: 'No se pudo cargar el catálogo: $e'),
      data: (schools) {
        final valid = schools.where((s) => s.id != null).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SchoolDropdown(control: control, schools: valid),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => const SchoolFormRoute().push<void>(context),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.accentDark,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              ),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text(
                'Crear nueva escuela',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SchoolDropdown extends StatelessWidget {
  final FormControl<int> control;
  final List<School> schools;
  const _SchoolDropdown({required this.control, required this.schools});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
      stream: control.valueChanges,
      initialData: control.value,
      builder: (context, snapshot) {
        return DropdownButtonFormField<int>(
          initialValue: snapshot.data,
          isExpanded: true,
          hint: const Text(
            'Selecciona una escuela',
            style: TextStyle(color: AppColors.textMuted),
          ),
          decoration: _fieldDecoration('Selecciona una escuela'),
          items: schools
              .map(
                (s) => DropdownMenuItem<int>(
                  value: s.id,
                  child: Text(
                    s.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              )
              .toList(),
          onChanged: (v) => control.value = v,
          validator: (v) => v == null ? 'Requerido' : null,
        );
      },
    );
  }
}

class _PickerSkeleton extends StatelessWidget {
  final String message;
  const _PickerSkeleton({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
