import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/forms/school_form_provider.dart';
import 'package:statball/app/providers/global/schools_provider.dart';
import 'package:statball/domain/index.dart' show School;
import 'package:statball/infrastructure/index.dart' show SchoolApiException;
import 'package:statball/ui/common/forms/sb_field_label.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ════════════════════════════════════════════════════════════════════════════
//  SCHOOL FORM SCREEN — pantalla completa para crear o editar una escuela.
//  En tablet/web limita el ancho a 640px para que la lectura sea cómoda.
// ════════════════════════════════════════════════════════════════════════════
class SchoolFormScreen extends ConsumerStatefulWidget {
  final int? schoolId;
  const SchoolFormScreen({super.key, this.schoolId});

  @override
  ConsumerState<SchoolFormScreen> createState() => _SchoolFormScreenState();
}

class _SchoolFormScreenState extends ConsumerState<SchoolFormScreen>
    with SnackbarsMixin {
  bool _saving = false;
  School? _existing;

  bool get _isEdit => widget.schoolId != null;

  @override
  void initState() {
    super.initState();
    // Hidrata el form si estamos en modo edición (post-frame para tener acceso a ref)
    if (_isEdit) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _hydrate());
    }
  }

  void _hydrate() {
    if (widget.schoolId == null) return;
    final school = ref.read(schoolsProvider.notifier).byId(widget.schoolId!);
    if (school == null) return;

    _existing = school;
    ref.read(schoolFormProvider).form.patchValue({
      'name': school.name,
      'site': school.site ?? '',
      'facebook': school.facebook ?? '',
      'instagram': school.instagram ?? '',
      'phoneNumber': school.phoneNumber ?? '',
      'email': school.email ?? '',
      'city': school.city ?? '',
      'state': school.state ?? '',
      'country': school.country ?? '',
      'principalId': school.principalId,
    });
  }

  @override
  void dispose() {
    // Limpia los valores del form al salir para no contaminar la próxima sesión
    ref.read(schoolFormProvider).form.reset();
    super.dispose();
  }

  String? _clean(Object? v) {
    final s = (v as String?)?.trim();
    return (s == null || s.isEmpty) ? null : s;
  }

  Future<void> _save() async {
    final form = ref.read(schoolFormProvider).form;
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    setState(() => _saving = true);
    final values = form.value;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final school = School(
      id: _existing?.id,
      name: (values['name'] as String).trim(),
      site: _clean(values['site']),
      facebook: _clean(values['facebook']),
      instagram: _clean(values['instagram']),
      phoneNumber: _clean(values['phoneNumber']),
      email: _clean(values['email']),
      city: _clean(values['city']),
      state: _clean(values['state']),
      country: _clean(values['country']),
      principalId: values['principalId'] as int?,
    );

    try {
      final notifier = ref.read(schoolsProvider.notifier);
      if (_isEdit) {
        await notifier.update(school);
        messenger.showSnackBar(successSnackBar(message: 'Escuela actualizada'));
      } else {
        await notifier.create(school);
        messenger.showSnackBar(successSnackBar(message: 'Escuela creada'));
      }
      form.reset();
      if (navigator.canPop()) navigator.pop();
    } on SchoolApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo guardar la escuela'),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(schoolFormProvider).form;
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
          _isEdit ? 'Editar escuela' : 'Nueva escuela',
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
                  const _SectionTitle('Datos básicos'),
                  const SizedBox(height: 12),
                  const _LabeledField(
                    name: 'name',
                    label: 'NOMBRE *',
                    hint: 'Nombre de la escuela',
                  ),
                  const SizedBox(height: 24),

                  const _SectionTitle('Contacto'),
                  const SizedBox(height: 12),
                  const _ResponsiveRow(
                    children: [
                      _LabeledField(
                        name: 'email',
                        label: 'EMAIL',
                        hint: 'correo@ejemplo.com',
                        keyboard: TextInputType.emailAddress,
                      ),
                      _LabeledField(
                        name: 'phoneNumber',
                        label: 'TELÉFONO',
                        hint: '+52 ...',
                        keyboard: TextInputType.phone,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const _LabeledField(
                    name: 'site',
                    label: 'SITIO WEB',
                    hint: 'https://...',
                    keyboard: TextInputType.url,
                  ),
                  const SizedBox(height: 12),
                  const _ResponsiveRow(
                    children: [
                      _LabeledField(
                        name: 'facebook',
                        label: 'FACEBOOK',
                        hint: 'usuario o URL',
                      ),
                      _LabeledField(
                        name: 'instagram',
                        label: 'INSTAGRAM',
                        hint: '@handle',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const _SectionTitle('Ubicación'),
                  const SizedBox(height: 12),
                  const _ResponsiveRow(
                    children: [
                      _LabeledField(
                        name: 'city',
                        label: 'CIUDAD',
                        hint: 'Ciudad',
                      ),
                      _LabeledField(
                        name: 'state',
                        label: 'ESTADO',
                        hint: 'Estado',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const _LabeledField(
                    name: 'country',
                    label: 'PAÍS',
                    hint: 'País',
                  ),
                  const SizedBox(height: 24),

                  const _SectionTitle('Director'),
                  const SizedBox(height: 12),
                  // Placeholder hasta que la feature de school_principals exista
                  Container(
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
                            'La asignación de director se habilitará cuando '
                            'registres directores en el catálogo.',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 12.5,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                  _isEdit ? 'Guardar cambios' : 'Crear escuela',
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

// ─── Helpers de layout y campos ──────────────────────────────────────────────

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

// Pone los hijos lado a lado en >=600px de ancho, apilados en móvil.
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
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.textMuted),
            filled: true,
            fillColor: AppColors.card,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
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
              borderSide: const BorderSide(
                color: AppColors.accentDark,
                width: 1.4,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 1.4),
            ),
          ),
          validationMessages: {
            ValidationMessage.required: (_) => 'Requerido',
            ValidationMessage.email: (_) => 'Correo inválido',
          },
        ),
      ],
    );
  }
}
