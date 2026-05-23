/*import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:statball/app/providers/utils/data_event_state.dart';
import 'package:statball/domain/index.dart' show SbUser, SbUserUseCase;

class SbUserCubit extends HydratedCubit<DataEventState> {
  SbUserCubit(this._repository) : super(InitialEvent());

  final SbUserUseCase _repository;

  Future<void> login({required String email, required String password}) async {
    emit(LoadingEvent());
    try {
      final user = await _repository.login(email: email, password: password);
      emit(SuccessEvent<SbUser>(user));
    } catch (e) {
      emit(ErrorEvent(e.toString()));
    }
  }

  Future<void> sendEmailToResetPassword({required String email}) async {
    emit(LoadingEvent());
    try {
      await _repository.sendResetPassEmail(email: email);
      emit(InitialEvent());
    } catch (e) {
      emit(ErrorEvent(e.toString()));
    }
  }

  @override
  Map<String, dynamic>? toJson(DataEventState state) {
    if (state is SuccessEvent<SbUser>) {
      return {'type': 'success', 'data': state.data.toJson()};
    }
    return null;
  }

  @override
  DataEventState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['type'] == 'success' && json['data'] != null) {
        return SuccessEvent<SbUser>(
          SbUser.fromJson(json['data'] as Map<String, dynamic>),
        );
      }
    } catch (_) {}
    return null;
  }
}
*/