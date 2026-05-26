import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/global/players_provider.dart';
import 'package:statball/app/providers/global/teams_provider.dart';
import 'package:statball/domain/index.dart' show Player, Team;

import 'widgets/player_list_tile.dart';

// ════════════════════════════════════════════════════════════════════════════
//  PLAYERS SCREEN — catálogo de jugadores. Acepta `teamFilter` opcional para
//  pre-filtrar el listado a un equipo específico (ej. desde el detalle de team).
// ════════════════════════════════════════════════════════════════════════════
class PlayersScreen extends ConsumerStatefulWidget {
  final String? teamFilter;
  const PlayersScreen({super.key, this.teamFilter});

  @override
  ConsumerState<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends ConsumerState<PlayersScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  String? _teamFilter;

  @override
  void initState() {
    super.initState();
    _teamFilter = widget.teamFilter;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncPlayers = ref.watch(playersProvider);
    final asyncTeams = ref.watch(teamsProvider);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        surfaceTintColor: AppColors.bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text(
          'Jugadores',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Recargar',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: asyncPlayers.isLoading
                ? null
                : () => ref.read(playersProvider.notifier).refresh(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            PlayerFormRoute(teamId: _teamFilter).push<void>(context),
        backgroundColor: AppColors.accentDark,
        foregroundColor: AppColors.onAccent,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Nuevo jugador',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _SearchBar(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
            ),
            _TeamFilterBar(
              selectedTeamId: _teamFilter,
              teamsAsync: asyncTeams,
              onChanged: (id) => setState(() => _teamFilter = id),
            ),
            Expanded(
              child: asyncPlayers.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.accentDark),
                ),
                error: (e, _) => _ErrorView(
                  message: e.toString(),
                  onRetry: () => ref.read(playersProvider.notifier).refresh(),
                ),
                data: (players) {
                  final filtered = _filter(players);
                  if (players.isEmpty) return const _EmptyView();
                  if (filtered.isEmpty) return const _NoMatchView();
                  return _PlayersList(
                    players: filtered,
                    teams: asyncTeams.value ?? const <Team>[],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Player> _filter(List<Player> all) {
    Iterable<Player> out = all;
    if (_teamFilter != null) {
      out = out.where((p) => p.teamId == _teamFilter);
    }
    if (_query.isNotEmpty) {
      out = out.where((p) {
        final hay = [p.firstname, p.lastname, p.city].join(' ').toLowerCase();
        return hay.contains(_query);
      });
    }
    return out.toList();
  }
}

class _PlayersList extends ConsumerWidget {
  final List<Player> players;
  final List<Team> teams;
  const _PlayersList({required this.players, required this.teams});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 720;
    final bottomGap = MediaQuery.of(context).padding.bottom + 96;
    final teamNames = {for (final t in teams) t.id: t.name};

    return RefreshIndicator(
      color: AppColors.accentDark,
      onRefresh: () => ref.read(playersProvider.notifier).refresh(),
      child: isWide
          ? GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20, 12, 20, bottomGap),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 460,
                mainAxisExtent: 110,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: players.length,
              itemBuilder: (_, i) => PlayerListTile(
                player: players[i],
                teamName: players[i].teamId == null
                    ? null
                    : teamNames[players[i].teamId],
              ),
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16, 12, 16, bottomGap),
              itemCount: players.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (_, i) => PlayerListTile(
                player: players[i],
                teamName: players[i].teamId == null
                    ? null
                    : teamNames[players[i].teamId],
              ),
            ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Buscar por nombre, apellido o ciudad...',
          hintStyle: const TextStyle(color: AppColors.textMuted),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
          ),
          filled: true,
          fillColor: AppColors.card,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.cardBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.cardBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.accentDark,
              width: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}

// Chip bar horizontal de equipos + "Todos" para limpiar + "Sin equipo".
class _TeamFilterBar extends StatelessWidget {
  final String? selectedTeamId;
  final AsyncValue<List<Team>> teamsAsync;
  final ValueChanged<String?> onChanged;

  const _TeamFilterBar({
    required this.selectedTeamId,
    required this.teamsAsync,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final teams = teamsAsync.value ?? const <Team>[];
    if (teams.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        children: [
          _FilterChip(
            label: 'Todos',
            selected: selectedTeamId == null,
            onTap: () => onChanged(null),
          ),
          for (final t in teams)
            if (t.id != null) ...[
              const SizedBox(width: 8),
              _FilterChip(
                label: t.name,
                selected: selectedTeamId == t.id,
                onTap: () => onChanged(t.id),
              ),
            ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.accentDark : AppColors.card,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.accentDark : AppColors.cardBorder,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.onAccent : AppColors.textPrimary,
              fontSize: 12.5,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: AppColors.accentSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                color: AppColors.accentDark,
                size: 48,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Aún no hay jugadores',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Registra el primero con el botón “Nuevo jugador”.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.5, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoMatchView extends StatelessWidget {
  const _NoMatchView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 42,
              color: AppColors.textMuted,
            ),
            SizedBox(height: 12),
            Text(
              'Sin resultados para el filtro aplicado',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 44,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accentDark,
                foregroundColor: AppColors.onAccent,
              ),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
