import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statball/app/providers/is_logged_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  Future<void> _logout(BuildContext context) async {
    final response = await showAdaptiveDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog.adaptive(
        title: const Center(child: Text('¿Cerrar sesión?')),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmar'),
          ),
        ],
        actionsAlignment: .center,
      ),
    ) ?? false;

    if (context.mounted) response ? context.read<IsLoggedCubit>().signOut() : ();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _logout(context);
      },
      icon: const Icon(Icons.logout_rounded),
    );
  }
}
