import 'package:flutter/material.dart';

class StatballApp extends StatelessWidget {
  const StatballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Statball',
    );
  }
}
