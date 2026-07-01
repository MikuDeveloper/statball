import 'package:flutter/material.dart';
import 'package:statball/app/config/routes/router.dart';
import 'package:statball/app/config/routes/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ElevatedButton(
          onPressed: () => routemaster.replace(rootPath),
          child: const Text('Go To Root'),
        ),
      ),
    );
  }
}
