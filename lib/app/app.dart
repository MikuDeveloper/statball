import 'package:flutter/material.dart';

import 'package:statball/app/config/themes/app_theme.dart';

import 'config/routes/router.dart';

class StatballApp extends StatelessWidget {
  const StatballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
      title: 'Statball',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: .system,
    );
  }
}
