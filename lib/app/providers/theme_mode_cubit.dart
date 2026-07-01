import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeModeCubit extends HydratedCubit<ThemeMode> {
  ThemeModeCubit() : super(.system);

  final String key = 'themeMode';

  void setDark() => emit(.dark);
  void setLight() => emit(.light);
  void setSystem() => emit(.system);

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    return json[key] == null ? ThemeMode.system : json[key] as ThemeMode;
  }

  @override
  Map<String, String> toJson(state) {
    return {key: state.name};
  }
}
