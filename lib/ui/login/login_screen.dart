import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/app/providers/forms/login_form_cubit.dart';
import 'package:statball/ui/shared/widgets/statball_widget.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Card(
                margin: const EdgeInsets.all(defaultPadding * 1.5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding * 1.5,
                    horizontal: defaultPadding * 2,
                  ),
                  child: Column(
                    mainAxisSize: .min,
                    mainAxisAlignment: .center,
                    children: [
                      const Align(alignment: .centerLeft, child: BackButton()),
                      StatballWidget(
                        before: 'Bienevenido a\n',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: defaultPadding),
                      //const LoginForm(),
                      BlocProvider(
                        create: (context) => LoginFormCubit(),
                        child: const LoginForm(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
