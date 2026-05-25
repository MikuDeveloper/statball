import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/forms/school_principal_form_provider.dart';
import 'package:statball/app/providers/global/school_principals_provider.dart';
import 'package:statball/domain/index.dart' show SchoolPrincipal;
import 'package:statball/infrastructure/index.dart'
    show SchoolPrincipalApiException;
import 'package:statball/ui/common/forms/sb_field_label.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

// ════════════════════════════════════════════════════════════════════════════
//  SCHOOL PRINCIPAL FORM SCREEN — crear o editar un director.
//  Limita ancho a 640px en >=720px para confort de lectura en tablet/web.
// ════════════════════════════════════════════════════════════════════════════
class SchoolPrincipalFormScreen extends ConsumerStatefulWidget {
  final int? principalId;
  const SchoolPrincipalFormScreen({super.key, this.principalId});

  @override
  ConsumerState<SchoolPrincipalFormScreen> createState() =>
      _SchoolPrincipalFormScreenState();
}

class _SchoolPrincipalFormScreenState
    extends ConsumerState<SchoolPrincipalFormScreen>
    with SnackbarsMixin {
  bool _saving = false;
  SchoolPrincipal? _existing;

  bool get _isEdit => widget.principalId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _hydrate());
    }
  }

  void _hydrate() {
    if (widget.principalId == null) return;
    final principal = ref
        .read(schoolPrincipalsProvider.notifier)
        .byId(widget.principalId!);
    if (principal == null) return;

    _existing = principal;
    ref.read(schoolPrincipalFormProvider).form.patchValue({
      'name': principal.name,
      'lastname': principal.lastname,
      'email': principal.email ?? '',
      'phoneNumber': principal.phoneNumber ?? '',
      'instagram': principal.instagram ?? '',
      'facebook': principal.facebook ?? '',
    });
  }

  @override
  void dispose() {
    ref.read(schoolPrincipalFormProvider).form.reset();
    super.dispose();
  }

  String? _clean(Object? v) {
    final s = (v as String?)?.trim();
    return (s == null || s.isEmpty) ? null : s;
  }

  Future<void> _save() async {
    final form = ref.read(schoolPrincipalFormProvider).form;
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    setState(() => _saving = true);
    final values = form.value;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final principal = SchoolPrincipal(
      id: _existing?.id,
      name: (values['name'] as String).trim(),
      lastname: (values['lastname'] as String).trim(),
      email: _clean(values['email']),
      phoneNumber: _clean(values['phoneNumber']),
      instagram: _clean(values['instagram']),
      facebook: _clean(values['facebook']),
    );

    try {
      final notifier = ref.read(schoolPrincipalsProvider.notifier);
      if (_isEdit) {
        await notifier.update(principal);
        messenger.showSnackBar(
          successSnackBar(message: 'Director actualizado'),
        );
      } else {
        await notifier.create(principal);
        messenger.showSnackBar(successSnackBar(message: 'Director creado'));
      }
      form.reset();
      if (navigator.canPop()) navigator.pop();
    } on SchoolPrincipalApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo guardar el director'),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(schoolPrincipalFormProvider).form;
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
          _isEdit ? 'Editar director' : 'Nuevo director',
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
                        hint: 'Ej. Juan',
                      ),
                      _LabeledField(
                        name: 'lastname',
                        label: 'APELLIDO *',
                        hint: 'Ej. García',
                      ),
                    ],
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
                  const SizedBox(height: 24),

                  const _SectionTitle('Redes sociales'),
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
                                  _isEdit
                                      ? 'Guardar cambios'
                                      : 'Crear director',
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
