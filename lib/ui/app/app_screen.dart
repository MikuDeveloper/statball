import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/app/providers/nav_index_cubit.dart';

import 'pages/index.dart';
import 'widgets/settings_button.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navIndex = context.watch<NavIndexCubit>().state;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('STATBALL'),
        actions: [
          const SettingsButton()
        ],
        actionsPadding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      ),
      body: [
        const DashboardPage(),
        const MatchesPage(),
        const PlayersPage(),
        const SchoolsPage(),
      ][navIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: navIndex,
        onDestinationSelected: (index) =>
            context.read<NavIndexCubit>().navigateTo(index),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Inicio',
          ),
          const NavigationDestination(
            icon: Icon(Icons.sports_soccer_rounded),
            label: 'Partidos',
          ),
          const NavigationDestination(
            icon: Icon(Icons.people_rounded),
            label: 'Jugadores',
          ),
          const NavigationDestination(
            icon: Icon(Icons.account_balance_rounded),
            label: 'Escuelas',
          ),
        ],
      ),
    );
  }
}
