import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_match_form_provider.g.dart';

// Form para programar / editar un partido. Validación cross-field:
// localTeamId ≠ visitorTeamId. La regla se duplica en el API por defensa
// en profundidad (por si el form se bypasea).
Map<String, dynamic>? _validateDifferentTeams(AbstractControl<dynamic> ctrl) {
  final group = ctrl as FormGroup;
  final local = group.control('localTeamId').value as String?;
  final visitor = group.control('visitorTeamId').value as String?;
  if (local != null && visitor != null && local == visitor) {
    return {'sameTeam': true};
  }
  return null;
}

@riverpod
({String key, FormGroup form}) gameMatchForm(Ref ref) {
  return (
    key: 'game_match_form',
    form: FormGroup(
      {
        'date': FormControl<DateTime>(
          value: null,
          validators: [Validators.required],
        ),
        'localTeamId': FormControl<String>(
          value: null,
          validators: [Validators.required],
        ),
        'visitorTeamId': FormControl<String>(
          value: null,
          validators: [Validators.required],
        ),
      },
      validators: [Validators.delegate(_validateDifferentTeams)],
    ),
  );
}
