import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/forms/scout_form_provider.dart';
import 'package:statball/app/providers/global/scouts_provider.dart';
import 'package:statball/domain/index.dart' show Scout;
import 'package:statball/infrastructure/index.dart' show ScoutApiException;
import 'package:statball/ui/common/forms/sb_field_label.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ════════════════════════════════════════════════════════════════════════════
//  SCOUT FORM SCREEN — crear o editar un scout (visoreador).
//  Todos los campos son requeridos en este momento (schema). Asterisco visible.
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
    // Reset al entrar (no en dispose) para no notificar listeners en unmount.
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
    // Default a 30 años atrás (rango típico de scout adulto)
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
