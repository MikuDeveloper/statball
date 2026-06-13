import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/forms/game_match_form_provider.dart';
import 'package:statball/app/providers/global/game_matches_provider.dart';
import 'package:statball/app/providers/global/teams_provider.dart';
import 'package:statball/domain/index.dart';
import 'package:statball/infrastructure/index.dart' show GameMatchApiException;
import 'package:statball/ui/common/forms/sb_field_label.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

import 'widgets/match_scouts_section.dart';

// ════════════════════════════════════════════════════════════════════════════
//  GAME MATCH FORM SCREEN — programa o edita un partido.
//  Validación cross-field: localTeamId ≠ visitorTeamId (en el form group +
//  defensa en API). En edit, sección "Scouts asignados" se hará en feature 7.
// ════════════════════════════════════════════════════════════════════════════
class GameMatchFormScreen extends ConsumerStatefulWidget {
  final int? matchId;
  const GameMatchFormScreen({super.key, this.matchId});

  @override
  ConsumerState<GameMatchFormScreen> createState() =>
      _GameMatchFormScreenState();
}

class _GameMatchFormScreenState extends ConsumerState<GameMatchFormScreen>
    with SnackbarsMixin {
  bool _saving = false;
  GameMatch? _existing;

  bool get _isEdit => widget.matchId != null;

  @override
  void initState() {
    super.initState();
    // Reset al entrar (no en dispose) para no notificar listeners en unmount.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(gameMatchFormProvider).form.reset();
      if (_isEdit) _hydrate();
    });
  }

  void _hydrate() {
    if (widget.matchId == null) return;
    final match = ref.read(gameMatchesProvider.notifier).byId(widget.matchId!);
    if (match == null) return;
    setState(() => _existing = match);
    ref.read(gameMatchFormProvider).form.patchValue({
      'date': match.date.toLocal(),
      'localTeamId': match.localTeamId,
      'visitorTeamId': match.visitorTeamId,
    });
  }

  bool get _isLiveWindow {
    final date = _existing?.date;
    if (date == null) return false;
    // Visible cuando el partido empieza dentro de ±2h del momento actual.
    return date.difference(DateTime.now()).inMinutes.abs() <= 120;
  }

  Future<void> _save() async {
    final form = ref.read(gameMatchFormProvider).form;
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    setState(() => _saving = true);
    final values = form.value;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final match = GameMatch(
      id: _existing?.id,
      date: values['date'] as DateTime,
      localTeamId: values['localTeamId'] as String,
      visitorTeamId: values['visitorTeamId'] as String,
    );

    try {
      final notifier = ref.read(gameMatchesProvider.notifier);
      if (_isEdit) {
        await notifier.updateMatch(match);
        messenger.showSnackBar(successSnackBar(message: 'Partido actualizado'));
      } else {
        await notifier.create(match);
        messenger.showSnackBar(successSnackBar(message: 'Partido programado'));
      }
      if (navigator.canPop()) navigator.pop();
    } on GameMatchApiException catch (e) {
      messenger.showSnackBar(errorSnackBar(message: e.message));
    } catch (_) {
      messenger.showSnackBar(
        errorSnackBar(message: 'No se pudo guardar el partido'),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(gameMatchFormProvider).form;
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
          _isEdit ? 'Editar partido' : 'Nuevo partido',
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
                  const _SectionTitle('Fecha y hora'),
                  const SizedBox(height: 12),
                  const _DateTimeField(),
                  const SizedBox(height: 24),

                  const _SectionTitle('Equipos'),
                  const SizedBox(height: 12),
                  const _TeamPicker(
                    name: 'localTeamId',
                    label: 'EQUIPO LOCAL *',
                    side: _TeamSide.local,
                  ),
                  const SizedBox(height: 12),
                  const _TeamPicker(
                    name: 'visitorTeamId',
                    label: 'EQUIPO VISITANTE *',
                    side: _TeamSide.visitor,
                  ),
                  const SizedBox(height: 8),
                  // Mensaje de validación cross-field (sameTeam)
                  ReactiveFormConsumer(
                    builder: (_, fg, _) {
                      final hasSameTeamError = fg.errors['sameTeam'] == true;
                      if (!hasSameTeamError) return const SizedBox.shrink();
                      return Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.error.withValues(alpha: 0.4),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 16,
                              color: AppColors.error,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'El equipo local y el visitante no pueden ser el mismo',
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // En modo edición ya existe match.id, así que podemos
                  // gestionar asignaciones de scouts (CRUD inmediato).
                  if (_isEdit) ...[
                    MatchScoutsSection(matchId: widget.matchId!),
                    const SizedBox(height: 16),
                  ],

                  // Botón "Iniciar visoría en vivo" — visible ±2h del partido.
                  if (_isEdit && _isLiveWindow) ...[
                    _LiveMatchButton(matchId: widget.matchId!),
                    const SizedBox(height: 16),
                  ],

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
                                      : 'Programar partido',
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
);

// ─── _DateTimeField ─────────────────────────────────────────────────────────
// Tap único abre DatePicker + TimePicker en cadena. Valor único en el form.
class _DateTimeField extends StatelessWidget {
  const _DateTimeField();

  @override
  Widget build(BuildContext context) {
    final control =
        (ReactiveForm.of(context) as FormGroup?)!.control('date')
            as FormControl<DateTime>;
    return StreamBuilder<DateTime?>(
      stream: control.valueChanges,
      initialData: control.value,
      builder: (_, snapshot) {
        final value = snapshot.data;
        final text = value == null
            ? 'Selecciona fecha y hora'
            : _formatDateTime(value);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SbFieldLabel(text: 'FECHA Y HORA *'),
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
                        Icons.event_rounded,
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

  String _formatDateTime(DateTime dt) {
    final dd = dt.day.toString().padLeft(2, '0');
    final mm = dt.month.toString().padLeft(2, '0');
    final hh = dt.hour.toString().padLeft(2, '0');
    final mn = dt.minute.toString().padLeft(2, '0');
    return '$dd/$mm/${dt.year} · $hh:$mn';
  }

  Future<void> _pick(
    BuildContext context,
    FormControl<DateTime> control,
  ) async {
    final now = DateTime.now();
    final initial = control.value ?? now.add(const Duration(hours: 1));
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      // Permitimos pasado y futuro: a veces se programan post-mortem.
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      helpText: 'Fecha del partido',
    );
    if (pickedDate == null) return;
    if (!context.mounted) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
      helpText: 'Hora del partido',
    );
    if (pickedTime == null) return;
    control.value = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    control.markAsTouched();
  }
}

// ─── _TeamPicker ────────────────────────────────────────────────────────────
enum _TeamSide { local, visitor }

class _TeamPicker extends ConsumerWidget {
  final String name;
  final String label;
  final _TeamSide side;
  const _TeamPicker({
    required this.name,
    required this.label,
    required this.side,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(teamsProvider);
    // Ya no necesitamos obtener el control manualmente — ReactiveDropdownField
    // se enlaza vía formControlName.

    return async.when(
      loading: () => const _PickerSkeleton(message: 'Cargando equipos...'),
      error: (e, _) =>
          _PickerSkeleton(message: 'No se pudo cargar el catálogo: $e'),
      data: (teams) {
        final valid = teams.where((t) => t.id != null).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SbFieldLabel(text: label),
            const SizedBox(height: 6),
            _TeamDropdown(formControlName: name, teams: valid),
            // Mostrar atajo "+ Crear equipo" solo en el dropdown local para
            // no duplicar — sirve igual desde cualquiera.
            if (side == _TeamSide.local) ...[
              const SizedBox(height: 4),
              TextButton.icon(
                onPressed: () => const TeamFormRoute().push<void>(context),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.accentDark,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 6,
                  ),
                ),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text(
                  'Crear nuevo equipo',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _TeamDropdown extends StatelessWidget {
  // Nota: ya no necesitamos `control` — ReactiveDropdownField lo enlaza
  // automáticamente al FormControl via el formControlName (los `_TeamPicker`
  // arriba pasan el `name`).
  final String formControlName;
  final List<Team> teams;
  const _TeamDropdown({required this.formControlName, required this.teams});

  @override
  Widget build(BuildContext context) {
    // ReactiveDropdownField mantiene el value sincronizado con el FormControl
    // bidireccionalmente. Reemplaza el patrón anterior (StreamBuilder +
    // DropdownButtonFormField.initialValue) que tenía un bug: initialValue
    // no es controlled, así que al rebuildear el snapshot el dropdown se
    // quedaba "pegado" al primer item independientemente de la selección.
    return ReactiveDropdownField<String>(
      formControlName: formControlName,
      isExpanded: true,
      hint: const Text(
        'Selecciona un equipo',
        style: TextStyle(color: AppColors.textMuted),
      ),
      decoration: _decoration('Selecciona un equipo'),
      items: teams
          .map(
            (t) => DropdownMenuItem<String>(
              value: t.id,
              child: Text(
                '${t.name} · ${t.category}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            ),
          )
          .toList(),
      validationMessages: {ValidationMessage.required: (_) => 'Requerido'},
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

// ─── _LiveMatchButton ────────────────────────────────────────────────────────
// Visible solo cuando el partido está dentro de ±2h del momento actual.
class _LiveMatchButton extends StatelessWidget {
  const _LiveMatchButton({required this.matchId});

  final int matchId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: FilledButton.icon(
        onPressed: () => LiveMatchRoute(id: matchId).go(context),
        icon: const Icon(Icons.sports_rounded, size: 20),
        label: const Text(
          'Iniciar visoría en vivo',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
