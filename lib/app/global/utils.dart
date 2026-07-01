import 'package:flutter/material.dart';

class Utils {
  static Color setColorForTheme({
    required BuildContext context,
    required Color light,
    required Color dark,
  }) {
    final themeMode = Theme.brightnessOf(context);
    return themeMode == .light ? light : dark;
  }
}
