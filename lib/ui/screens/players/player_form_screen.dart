import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/enums.dart'
    show FootPreference, PlayerPosition;
import 'package:statball/app/providers/forms/player_form_provider.dart';
import 'package:statball/app/providers/global/players_provider.dart';
import 'package:statball/app/providers/global/scouts_provider.dart';
import 'package:statball/app/providers/global/teams_provider.dart';
import 'package:statball/domain/index.dart' show Player, Scout, Team;
import 'package:statball/infrastructure/index.dart' show PlayerApiException;
import 'package:statball/ui/common/forms/sb_field_label.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ════════════════════════════════════════════════════════════════════════════
//  PLAYER FORM SCREEN — pantalla completa para crear o editar un jugador.
//  Acepta `teamId` opcional para pre-seleccionar el equipo en creación.
// ════════════════════════════════════════════════════════════════════════════
class PlayerFormScreen extends ConsumerStatefulWidget {
  final String? playerId;
  final String? presetTeamId;
  const PlayerFormScreen({super.key, this.playerId, this.presetTeamId});

  @override
  ConsumerState<PlayerFormScreen> createState() => _PlayerFormScreenState();
}

class _PlayerFormScreenState extends ConsumerState<PlayerFormScreen>
    with SnackbarsMixin {
  bool _saving = false;
  Player? _existing;

  bool get _isEdit => widget.playerId != null;

  @override
  void initState() {
    super.initState();
    // Reset al entrar (no en dispose) para no notificar listeners en unmount.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(playerFormProvider).form.reset();
      _hydrate();
    });
  }

  void _hydrate() {
    final form = ref.read(playerFormProvider).form;
    if (_isEdit) {
      final player = ref.read(playersProvider.notifier).byId(widget.playerId!);
      if (player == null) return;
      _existing = player;
      // Text fields se inicializan con '' (no null) para que el TextField
      // muestre el campo vacío; numéricos y fecha se pasan como están.
      form.patchValue({
        'firstname': player.firstname,
        'lastname': player.lastname,
        'birthday': player.birthday,
        'height': player.height,
        'weight': player.weight,
        'notes': player.notes ?? '',
        'preferredFoot': player.preferredFoot,
        'basicForces': player.basicForces,
        'city': player.city ?? '',
        'country': player.country ?? '',
        'photo': player.photo ?? '',
        'teamId': player.teamId,
        'scoutId': player.scoutId,
        'defaultPosition': player.defaultPosition,
      });
    } else if (widget.presetTeamId != null) {
      form.control('teamId').value = widget.presetTeamId;
    }
  }

  // El reset vive en initState (al entrar) para no notificar listeners en unmount.

  Future<void> _save() async {
    final form = ref.read(playerFormProvider).form;
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    setState(() => _saving = true);
    final values = form.value;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    // Texto vacío del form lo enviamos como null al modelo (luego la API filtra
    // los nulls del payload con removeWhere para no sobreescribir columnas).
    String? cleanText(Object? v) {
      final s = (v as String?)?.trim();
      return (s == null || s.isEmpty) ? null : s;
    }

    final player = Player(
      id: _existing?.id,
      firstname: (values['firstname'] as String).trim(),
      lastname: (values['lastname'] as String).trim(),
      birthday: values['birthday'] as DateTime?,
      height: values['height'] as double?,
      weight: values['weight'] as double?,
      notes: cleanText(values['notes']),
      preferredFoot: values['preferredFoot'] as FootPreference,
      basicForces: values['basicForces'] as bool? ?? false,
      city: cleanText(values['city']),
      country: cleanText(values['country']),
      photo: cleanText(values['photo']),
      teamId: values['teamId'] as String?,
      // Requerido por el form (Validators.required) → non-null al guardar.
      scoutId: values['scoutId'] as String,
      defaultPosition: values['defaultPosition'] as PlayerPosition,
    );

    try {
      final notifier = ref.read(playersProvider.notifier);
      if (_isEdit) {
        await notifier.updatePlayer(player);
        messenger.showSnackBar(successSnackBar(message: 'Jugador actualizado'));
      } else {
        await notifier.create(player);
        messenger.showSnackBar(successSnackBar(message: 'Jugador creado'));
      }
      form.reset();
      if (navigator.canPop()) navigator.pop();
    } on PlayerApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo guardar el jugador'),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(playerFormProvider).form;
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
          _isEdit ? 'Editar jugador' : 'Nuevo jugador',
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
                  const _SectionTitle('Datos personales'),
                  const SizedBox(height: 12),
                  const _ResponsiveRow(
                    children: [
                      _LabeledField(
                        name: 'firstname',
                        label: 'NOMBRE *',
                        hint: 'Ej. Andrés',
                      ),
                      _LabeledField(
                        name: 'lastname',
                        label: 'APELLIDO *',
                        hint: 'Ej. García',
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  const _SectionTitle('Perfil deportivo'),
                  const SizedBox(height: 12),
                  const SbFieldLabel(text: 'PIE PREFERIDO *'),
                  const SizedBox(height: 8),
                  const _FootPicker(),
                  const SizedBox(height: 16),
                  const SbFieldLabel(text: 'POSICIÓN PRINCIPAL *'),
                  const SizedBox(height: 8),
                  const _PositionPicker(),
                  const SizedBox(height: 14),
                  const _BasicForcesSwitch(),
                  const SizedBox(height: 18),

                  const _SectionTitle('Equipo'),
                  const SizedBox(height: 12),
                  const _TeamPicker(),
                  const SizedBox(height: 18),

                  const _SectionTitle('Scout responsable'),
                  const SizedBox(height: 12),
                  const _ScoutPicker(),
                  const SizedBox(height: 18),

                  // Todo lo demás es opcional y se puede completar después.
                  // Lo colapsamos para no abrumar al usuario en alta rápida.
                  const _OptionalFieldsSection(),
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
                                  _isEdit ? 'Guardar cambios' : 'Crear jugador',
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

InputDecoration _decoration(String hint) => InputDecoration(
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
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.error),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.error, width: 1.4),
  ),
);

class _LabeledField extends StatelessWidget {
  final String name;
  final String label;
  final String hint;
  final TextInputType keyboard;

  const _LabeledField({
    required this.name,
    required this.label,
    required this.hint,
    this.keyboard = TextInputType.text,
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
          keyboardType: keyboard,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _decoration(hint),
          validationMessages: {ValidationMessage.required: (_) => 'Requerido'},
        ),
      ],
    );
  }
}

// Campo numérico decimal con teclado numérico
class _NumericField extends StatelessWidget {
  final String name;
  final String label;
  final String hint;
  const _NumericField({
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
        ReactiveTextField<double>(
          formControlName: name,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
          ],
          valueAccessor: _DoubleValueAccessor(),
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _decoration(hint),
          validationMessages: {
            ValidationMessage.required: (_) => 'Requerido',
            ValidationMessage.number: (_) => 'Número inválido',
            ValidationMessage.min: (_) => 'Valor demasiado bajo',
          },
        ),
      ],
    );
  }
}

// Reactive Forms espera control<double>; el TextField trabaja con String.
// Este accessor convierte entre ambos y acepta comas como separador decimal.
class _DoubleValueAccessor extends ControlValueAccessor<double, String> {
  @override
  String modelToViewValue(double? modelValue) {
    if (modelValue == null) return '';
    // Si el número es entero, mostramos sin ".0" para no confundir al usuario
    if (modelValue % 1 == 0) return modelValue.toInt().toString();
    return modelValue.toString();
  }

  @override
  double? viewToModelValue(String? viewValue) {
    if (viewValue == null || viewValue.trim().isEmpty) return null;
    return double.tryParse(viewValue.replaceAll(',', '.'));
  }
}

// ─── _BirthdayField ─────────────────────────────────────────────────────────
class _BirthdayField extends StatelessWidget {
  const _BirthdayField();

  @override
  Widget build(BuildContext context) {
    final control =
        (ReactiveForm.of(context) as FormGroup?)!.control('birthday')
            as FormControl<DateTime>;
    return StreamBuilder<DateTime?>(
      stream: control.valueChanges,
      initialData: control.value,
      builder: (_, snapshot) {
        final value = snapshot.data;
        final text = value == null
            ? 'Selecciona fecha de nacimiento'
            : '${value.day.toString().padLeft(2, '0')}/'
                  '${value.month.toString().padLeft(2, '0')}/'
                  '${value.year}';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SbFieldLabel(text: 'FECHA DE NACIMIENTO'),
            const SizedBox(height: 6),
            Material(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () => _pick(context, control),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        size: 18,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          text,
                          style: TextStyle(
                            color: value == null
                                ? AppColors.textMuted
                                : AppColors.textPrimary,
                            fontSize: 14.5,
                            fontWeight: value == null
                                ? FontWeight.w400
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                      if (value != null)
                        const Icon(
                          Icons.edit_rounded,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (value != null)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: TextButton.icon(
                  onPressed: () {
                    control.value = null;
                    control.markAsTouched();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textMuted,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 24),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: const Icon(Icons.clear_rounded, size: 14),
                  label: const Text(
                    'Quitar fecha',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _pick(
    BuildContext context,
    FormControl<DateTime> control,
  ) async {
    final now = DateTime.now();
    final initial =
        control.value ?? DateTime(now.year - 15, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1950),
      lastDate: now,
      helpText: 'Fecha de nacimiento',
    );
    if (picked != null) {
      control.value = picked;
      control.markAsTouched();
    }
  }
}

// ─── _BasicForcesSwitch ─────────────────────────────────────────────────────
class _BasicForcesSwitch extends StatelessWidget {
  const _BasicForcesSwitch();

  @override
  Widget build(BuildContext context) {
    final control =
        (ReactiveForm.of(context) as FormGroup?)!.control('basicForces')
            as FormControl<bool>;
    return StreamBuilder<bool?>(
      stream: control.valueChanges,
      initialData: control.value,
      builder: (_, snapshot) {
        final on = snapshot.data ?? false;
        return Material(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () => control.value = !on,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: on ? AppColors.accentAlt : AppColors.cardBorder,
                  width: on ? 1.4 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.fitness_center_rounded,
                    color: on ? AppColors.accentAlt : AppColors.textMuted,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fuerzas básicas',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Tiene preparación física fundamental',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: on,
                    onChanged: (v) => control.value = v,
                    // activeColor está deprecated en Flutter 3.31+
                    activeThumbColor: AppColors.accentAlt,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── _FootPicker ────────────────────────────────────────────────────────────
class _FootPicker extends StatelessWidget {
  const _FootPicker();

  @override
  Widget build(BuildContext context) {
    final control =
        (ReactiveForm.of(context) as FormGroup?)!.control('preferredFoot')
            as FormControl<FootPreference>;

    return StreamBuilder<FootPreference?>(
      stream: control.valueChanges,
      initialData: control.value,
      builder: (_, snapshot) {
        final current = snapshot.data;
        return Row(
          children: [
            for (final f in FootPreference.values) ...[
              Expanded(
                child: _FootChip(
                  foot: f,
                  selected: current == f,
                  onTap: () => control.value = f,
                ),
              ),
              if (f != FootPreference.values.last) const SizedBox(width: 8),
            ],
          ],
        );
      },
    );
  }
}

class _FootChip extends StatelessWidget {
  final FootPreference foot;
  final bool selected;
  final VoidCallback onTap;
  const _FootChip({
    required this.foot,
    required this.selected,
    required this.onTap,
  });

  IconData get _icon => switch (foot) {
    FootPreference.izquierda => Icons.arrow_back_rounded,
    FootPreference.derecha => Icons.arrow_forward_rounded,
    FootPreference.ambidiestro => Icons.swap_horiz_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final color = AppColors.accentDark;
    return Material(
      color: selected ? color : AppColors.card,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? color : AppColors.cardBorder,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _icon,
                color: selected ? AppColors.onAccent : color,
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                foot.label,
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

// ─── _PositionPicker ──────────────────────────────────────────────────────────
// Chips compactos con las 8 posiciones. Required, default MEDIOCENTRO.
class _PositionPicker extends StatelessWidget {
  const _PositionPicker();

  @override
  Widget build(BuildContext context) {
    final control =
        (ReactiveForm.of(context) as FormGroup?)!.control('defaultPosition')
            as FormControl<PlayerPosition>;

    return StreamBuilder<PlayerPosition?>(
      stream: control.valueChanges,
      initialData: control.value,
      builder: (_, snapshot) {
        final current = snapshot.data;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in PlayerPosition.values)
              _PositionChip(
                position: p,
                selected: current == p,
                onTap: () {
                  control.value = p;
                  control.markAsTouched();
                },
              ),
          ],
        );
      },
    );
  }
}

class _PositionChip extends StatelessWidget {
  final PlayerPosition position;
  final bool selected;
  final VoidCallback onTap;
  const _PositionChip({
    required this.position,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.accentDark;
    return Material(
      color: selected ? color : AppColors.card,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? color : AppColors.cardBorder,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Text(
            position.label,
            style: TextStyle(
              color: selected ? AppColors.onAccent : AppColors.textPrimary,
              fontSize: 12.5,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── _TeamPicker ────────────────────────────────────────────────────────────
// Dropdown nullable (un jugador puede no tener equipo).
class _TeamPicker extends ConsumerWidget {
  const _TeamPicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(teamsProvider);

    return async.when(
      loading: () => const _PickerSkeleton(message: 'Cargando equipos...'),
      error: (e, _) => _PickerSkeleton(message: 'No se pudo cargar: $e'),
      data: (teams) {
        final valid = teams.where((t) => t.id != null).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TeamDropdown(teams: valid),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => TeamFormRoute().push<void>(context),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.accentDark,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              ),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text(
                'Crear nuevo equipo',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Dropdown nullable usando ReactiveDropdownField:
// - Item "Sin equipo" con value=null permite limpiar la selección sin botón externo.
// - ReactiveDropdownField se enlaza al FormControl<String> (que acepta null).
class _TeamDropdown extends StatelessWidget {
  final List<Team> teams;
  const _TeamDropdown({required this.teams});

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField<String>(
      formControlName: 'teamId',
      isExpanded: true,
      hint: const Text(
        'Sin equipo',
        style: TextStyle(color: AppColors.textMuted),
      ),
      decoration: _decoration('Sin equipo'),
      items: [
        const DropdownMenuItem<String>(
          value: null,
          child: Text(
            'Sin equipo',
            style: TextStyle(color: AppColors.textMuted),
          ),
        ),
        ...teams.map(
          (t) => DropdownMenuItem<String>(
            value: t.id,
            child: Text(
              '${t.name} · ${t.category}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── _ScoutPicker ───────────────────────────────────────────────────────────
// Dropdown obligatorio: cada jugador debe tener un scout responsable
// (players.scout_id NOT NULL). Lista el catálogo completo de scouts.
class _ScoutPicker extends ConsumerWidget {
  const _ScoutPicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(scoutsProvider);

    return async.when(
      loading: () => const _PickerSkeleton(message: 'Cargando scouts...'),
      error: (e, _) => _PickerSkeleton(message: 'No se pudo cargar: $e'),
      data: (scouts) {
        final valid = scouts.where((s) => s.id != null).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _RequiredLabel(text: 'SCOUT RESPONSABLE'),
            const SizedBox(height: 6),
            _ScoutDropdown(scouts: valid),
          ],
        );
      },
    );
  }
}

// Dropdown enlazado a 'scoutId'. Sin opción nula: el campo es obligatorio,
// la validación required del FormControl bloquea el guardado si no se elige.
class _ScoutDropdown extends StatelessWidget {
  final List<Scout> scouts;
  const _ScoutDropdown({required this.scouts});

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField<String>(
      formControlName: 'scoutId',
      isExpanded: true,
      hint: const Text(
        'Selecciona un scout',
        style: TextStyle(color: AppColors.textMuted),
      ),
      decoration: _decoration('Selecciona un scout'),
      validationMessages: {ValidationMessage.required: (_) => 'Requerido'},
      items: scouts
          .map(
            (s) => DropdownMenuItem<String>(
              value: s.id,
              child: Text(
                '${s.name} ${s.lastname}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            ),
          )
          .toList(),
    );
  }
}

// Label con asterisco rojo para campos obligatorios.
class _RequiredLabel extends StatelessWidget {
  final String text;
  const _RequiredLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(letterSpacing: 0.2);
    return Text.rich(
      TextSpan(
        text: text,
        style: base,
        children: [
          TextSpan(
            text: ' *',
            style: base?.copyWith(color: AppColors.error),
          ),
        ],
      ),
    );
  }
}

// ─── _NotesField ────────────────────────────────────────────────────────────
class _NotesField extends StatelessWidget {
  const _NotesField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SbFieldLabel(text: 'NOTAS'),
        const SizedBox(height: 6),
        ReactiveTextField<String>(
          formControlName: 'notes',
          maxLines: 4,
          minLines: 3,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _decoration(
            'Observaciones, lesiones, talento destacado...',
          ),
        ),
      ],
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

// ─── _OptionalFieldsSection ─────────────────────────────────────────────────
// Agrupa todo lo que no es obligatorio en un ExpansionTile colapsado para
// que el alta rápida no se sienta abrumadora. El usuario puede completar
// estos datos después editando al jugador.
class _OptionalFieldsSection extends StatelessWidget {
  const _OptionalFieldsSection();

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Quita la línea separadora gris del ExpansionTile (estética)
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 18),
          collapsedIconColor: AppColors.textMuted,
          iconColor: AppColors.accentDark,
          title: const Text(
            'Datos opcionales',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          subtitle: const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              'Puedes completarlos después',
              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
          ),
          children: const [
            _SectionTitle('Físico'),
            SizedBox(height: 10),
            _BirthdayField(),
            SizedBox(height: 12),
            _ResponsiveRow(
              children: [
                _NumericField(
                  name: 'height',
                  label: 'ALTURA (m)',
                  hint: 'Ej. 1.78',
                ),
                _NumericField(
                  name: 'weight',
                  label: 'PESO (kg)',
                  hint: 'Ej. 72.5',
                ),
              ],
            ),
            SizedBox(height: 18),

            _SectionTitle('Ubicación'),
            SizedBox(height: 10),
            _ResponsiveRow(
              children: [
                _LabeledField(name: 'city', label: 'CIUDAD', hint: 'Ciudad'),
                _LabeledField(name: 'country', label: 'PAÍS', hint: 'País'),
              ],
            ),
            SizedBox(height: 18),

            _SectionTitle('Extras'),
            SizedBox(height: 10),
            _LabeledField(
              name: 'photo',
              label: 'URL DE FOTO',
              hint: 'https://...',
              keyboard: TextInputType.url,
            ),
            SizedBox(height: 12),
            _NotesField(),
          ],
        ),
      ),
    );
  }
}
