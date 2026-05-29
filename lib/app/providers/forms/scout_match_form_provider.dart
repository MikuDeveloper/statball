import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scout_match_form_provider.g.dart';

// Form del bottom sheet de asignación: scout obligatorio, notas opcionales
// (la columna es NOT NULL en DB, así que enviamos '' cuando va vacío).
@riverpod
({String key, FormGroup form}) scoutMatchForm(Ref ref) {
  return (
    key: 'scout_match_form',
    form: FormGroup({
      'scoutId': FormControl<String>(
        value: null,
        validators: [Validators.required],
      ),
      'notes': FormControl<String>(value: ''),
    }),
  );
}
