import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:statball/app/providers/theme_mode_cubit.dart';

import 'config/routes/router.dart';
import 'config/theme/dark_theme.dart';
import 'config/theme/light_theme.dart';

class StatballApp extends StatelessWidget {
  const StatballApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeModeCubit>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: routemaster,
      routeInformationParser: const RoutemasterParser(),
      title: 'Statball',
      theme: LightTheme.themeData,
      darkTheme: DarkTheme.themeData,
      themeMode: themeMode.state,
    );
  }
}
