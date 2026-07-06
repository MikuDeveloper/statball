import 'package:flutter/material.dart';
import 'package:statball/app/global/constants.dart' show defaultPadding;

import 'widgets/logout_button.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [const LogoutButton()],
        actionsPadding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      ),
      body: const Center(child: Text('App Screen')),
    );
  }
}
