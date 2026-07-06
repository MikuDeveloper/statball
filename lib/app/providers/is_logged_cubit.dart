import 'package:hydrated_bloc/hydrated_bloc.dart';

class IsLoggedCubit extends HydratedCubit<bool> {
  IsLoggedCubit() : super(false);

  final String key = 'isLogged';

  void signIn() => emit(true);
  void signOut() => emit(false);

  @override
  bool fromJson(Map<String, dynamic> json) {
    return json[key] as bool? ?? false;
  }

  @override
  Map<String, bool>? toJson(bool state) {
    return {key: state};
  }
}
