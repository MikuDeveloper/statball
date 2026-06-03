import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/forms/scout_form_provider.dart';
import 'package:statball/app/providers/global/sb_user_data_provider.dart';
import 'package:statball/app/providers/global/scouts_provider.dart';
import 'package:statball/app/providers/global/unlinked_scout_profiles_provider.dart';
import 'package:statball/domain/index.dart' show Scout, SbUser;
import 'package:statball/infrastructure/index.dart' show ScoutApiException;
import 'package:statball/ui/common/forms/sb_field_label.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ════════════════════════════════════════════════════════════════════════════
//  SCOUT FORM SCREEN — crear o editar un scout (visoreador).
//  Sección "Cuenta de la app" visible solo para super_scout.
// ════════════════════════════════════════════════════════════════════════════
class ScoutFormScreen extends ConsumerStatefulWidget {
  final String? scoutId;
  const ScoutFormScreen({super.key, this.scoutId});

  @override
  ConsumerState<ScoutFormScreen> createState() => _ScoutFormScreenState();
}

class _ScoutFormScreenState extends ConsumerState<ScoutFormScreen>
    with SnackbarsMixin {
  bool _saving = false;
  Scout? _existing;

  bool get _isEdit => widget.scoutId != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(scoutFormProvider).form.reset();
      if (_isEdit) _hydrate();
    });
  }

  void _hydrate() {
    if (widget.scoutId == null) return;
    final scout = ref.read(scoutsProvider.notifier).byId(widget.scoutId!);
    if (scout == null) return;
    _existing = scout;
    ref.read(scoutFormProvider).form.patchValue({
      'name': scout.name,
      'lastname': scout.lastname,
      'birthday': scout.birthday,
      'phoneNumber': scout.phoneNumber,
      'address': scout.address,
      'photo': scout.photo,
      'userId': scout.userId,
    });
  }

  Future<void> _save() async {
    final form = ref.read(scoutFormProvider).form;
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    setState(() => _saving = true);
    final values = form.value;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final scout = Scout(
      id: _existing?.id,
      name: (values['name'] as String).trim(),
      lastname: (values['lastname'] as String).trim(),
      birthday: values['birthday'] as DateTime,
      phoneNumber: (values['phoneNumber'] as String).trim(),
      address: (values['address'] as String).trim(),
      photo: (values['photo'] as String).trim(),
      userId: values['userId'] as String?,
    );

    try {
      final notifier = ref.read(scoutsProvider.notifier);
      if (_isEdit) {
        await notifier.updateScout(scout);
        messenger.showSnackBar(successSnackBar(message: 'Scout actualizado'));
      } else {
        await notifier.create(scout);
        messenger.showSnackBar(successSnackBar(message: 'Scout creado'));
      }
      form.reset();
      if (navigator.canPop()) navigator.pop();
    } on ScoutApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo guardar el scout'),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(scoutFormProvider).form;
    final currentUser = ref.watch(sbUserDataProvider).value;
    final isSuperScout = currentUser?.role == 'super_scout';
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
          _isEdit ? 'Editar scout' : 'Nuevo scout',
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
                        name: 'name',
                        label: 'NOMBRE *',
                        hint: 'Ej. Carlos',
                      ),
                      _LabeledField(
                        name: 'lastname',
                        label: 'APELLIDO *',
                        hint: 'Ej. Méndez',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const _BirthdayField(),
                  const SizedBox(height: 24),

                  const _SectionTitle('Contacto'),
                  const SizedBox(height: 12),
                  const _LabeledField(
                    name: 'phoneNumber',
                    label: 'TELÉFONO *',
                    hint: '+52 ...',
                    keyboard: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  const _LabeledField(
                    name: 'address',
                    label: 'DIRECCIÓN *',
                    hint: 'Calle, número, colonia',
                  ),
                  const SizedBox(height: 24),

                  const _SectionTitle('Foto'),
                  const SizedBox(height: 12),
                  const _LabeledField(
                    name: 'photo',
                    label: 'URL DE FOTO *',
                    hint: 'https://...',
                    keyboard: TextInputType.url,
                  ),

                  // Sección de vinculación — solo visible para super_scout
                  if (isSuperScout) ...[
                    const SizedBox(height: 24),
                    _AppAccountSection(
                      scoutId: widget.scoutId,
                      existingUserId: _existing?.userId,
                    ),
                  ],

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
                                  _isEdit ? 'Guardar cambios' : 'Crear scout',
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

// ─── _AppAccountSection ─────────────────────────────────────────────────────
// ExpansionTile "Cuenta de la app · opcional", solo para super_scout.
// Muestra dropdown con perfiles disponibles y botón de desvincular si hay vínculo.
class _AppAccountSection extends ConsumerWidget {
  final String? scoutId;
  final String? existingUserId;
  const _AppAccountSection({this.scoutId, this.existingUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(
      unlinkedScoutProfilesProvider(excludeScoutId: scoutId),
    );
    final userIdControl =
        (ReactiveForm.of(context) as FormGroup?)!.control('userId')
            as FormControl<String>;

    return StreamBuilder<String?>(
      stream: userIdControl.valueChanges,
      initialData: userIdControl.value,
      builder: (_, snapshot) {
        final currentValue = snapshot.data;
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.cardBorder),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.card,
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 14),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            title: const Text(
              'Cuenta de la app · opcional',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
            subtitle: currentValue != null
                ? Text(
                    _emailForId(profilesAsync.value, currentValue) ??
                        'Vinculado',
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: AppColors.accentDark,
                    ),
                  )
                : const Text(
                    'Sin cuenta vinculada',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: AppColors.textMuted,
                    ),
                  ),
            children: [
              profilesAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, _) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Error al cargar perfiles',
                    style: TextStyle(color: AppColors.error, fontSize: 12),
                  ),
                ),
                data: (profiles) {
                  // Si ya hay un vínculo, incluir ese profile en el listado
                  final all = [...profiles];
                  if (currentValue != null &&
                      !all.any((p) => p.id == currentValue)) {
                    // El profile vinculado no está en la lista "libres" —
                    // lo añadimos con email mínimo para mostrarlo correctamente.
                    // (Esto ocurre en edición si el filtro ya lo excluye.)
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SbFieldLabel(text: 'CUENTA (EMAIL)'),
                      const SizedBox(height: 6),
                      InputDecorator(
                        decoration: _dropdownDecoration(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: currentValue,
                            isExpanded: true,
                            hint: const Text(
                              'Selecciona un perfil',
                              style: TextStyle(color: AppColors.textMuted),
                            ),
                            items: [
                              const DropdownMenuItem<String>(
                                value: null,
                                child: Text(
                                  'Sin vínculo',
                                  style: TextStyle(color: AppColors.textMuted),
                                ),
                              ),
                              ...all.map(
                                (p) => DropdownMenuItem<String>(
                                  value: p.id,
                                  child: Text(
                                    p.email,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (v) {
                              userIdControl.value = v;
                              userIdControl.markAsTouched();
                            },
                          ),
                        ),
                      ),
                      if (currentValue != null) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: const Icon(
                              Icons.link_off_rounded,
                              size: 16,
                              color: AppColors.error,
                            ),
                            label: const Text(
                              'Desvincular cuenta',
                              style: TextStyle(color: AppColors.error),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.error),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              userIdControl.value = null;
                              userIdControl.markAsTouched();
                            },
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String? _emailForId(List<SbUser>? profiles, String id) {
    if (profiles == null) return null;
    for (final p in profiles) {
      if (p.id == id) return p.email;
    }
    return null;
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

InputDecoration _dropdownDecoration() => InputDecoration(
  filled: true,
  fillColor: AppColors.bgLight,
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
            const SbFieldLabel(text: 'FECHA DE NACIMIENTO *'),
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
                    border: Border.all(
                      color: control.touched && control.invalid
                          ? AppColors.error
                          : AppColors.cardBorder,
                    ),
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
            if (control.touched && control.invalid)
              const Padding(
                padding: EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  'Requerido',
                  style: TextStyle(color: AppColors.error, fontSize: 12),
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
        control.value ?? DateTime(now.year - 30, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1940),
      lastDate: now,
      helpText: 'Fecha de nacimiento',
    );
    if (picked != null) {
      control.value = picked;
      control.markAsTouched();
    }
  }
}
