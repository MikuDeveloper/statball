import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/global/schools_provider.dart';
import 'package:statball/app/providers/global/teams_provider.dart';
import 'package:statball/domain/index.dart' show School, Team;

import 'widgets/team_list_tile.dart';

// ════════════════════════════════════════════════════════════════════════════
//  TEAMS SCREEN — catálogo de equipos. Acepta `schoolId` opcional para
//  pre-filtrar a los equipos de una escuela específica (ej. al venir desde
//  el form de schools en modo edición).
// ════════════════════════════════════════════════════════════════════════════
class TeamsScreen extends ConsumerStatefulWidget {
  final int? schoolFilter;
  const TeamsScreen({super.key, this.schoolFilter});

  @override
  ConsumerState<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends ConsumerState<TeamsScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  int? _schoolFilter;

  @override
  void initState() {
    super.initState();
    _schoolFilter = widget.schoolFilter;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncTeams = ref.watch(teamsProvider);
    final asyncSchools = ref.watch(schoolsProvider);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        surfaceTintColor: AppColors.bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text(
          'Equipos',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Jugadores',
            icon: const Icon(Icons.person_outline_rounded),
            onPressed: () => const PlayersRoute().push<void>(context),
          ),
          IconButton(
            tooltip: 'Recargar',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: asyncTeams.isLoading
                ? null
                : () => ref.read(teamsProvider.notifier).refresh(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            TeamFormRoute(schoolId: _schoolFilter).push<void>(context),
        backgroundColor: AppColors.accentDark,
        foregroundColor: AppColors.onAccent,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Nuevo equipo',
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
            _SchoolFilterBar(
              selectedSchoolId: _schoolFilter,
              schoolsAsync: asyncSchools,
              onChanged: (id) => setState(() => _schoolFilter = id),
            ),
            Expanded(
              child: asyncTeams.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.accentDark),
                ),
                error: (e, _) => _ErrorView(
                  message: e.toString(),
                  onRetry: () => ref.read(teamsProvider.notifier).refresh(),
                ),
                data: (teams) {
                  final filtered = _filter(teams);
                  if (teams.isEmpty) return const _EmptyView();
                  if (filtered.isEmpty) return const _NoMatchView();
                  return _TeamsList(
                    teams: filtered,
                    schools: asyncSchools.value ?? const <School>[],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Team> _filter(List<Team> all) {
    Iterable<Team> out = all;
    if (_schoolFilter != null) {
      out = out.where((t) => t.schoolId == _schoolFilter);
    }
    if (_query.isNotEmpty) {
      out = out.where((t) {
        final hay = [t.name, t.category, t.coachName].join(' ').toLowerCase();
        return hay.contains(_query);
      });
    }
    return out.toList();
  }
}

class _TeamsList extends ConsumerWidget {
  final List<Team> teams;
  final List<School> schools;
  const _TeamsList({required this.teams, required this.schools});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 720;
    final bottomGap = MediaQuery.of(context).padding.bottom + 96;
    // Index para resolver nombre de escuela en O(1)
    final schoolNames = {for (final s in schools) s.id: s.name};

    return RefreshIndicator(
      color: AppColors.accentDark,
      onRefresh: () => ref.read(teamsProvider.notifier).refresh(),
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
              itemCount: teams.length,
              itemBuilder: (_, i) => TeamListTile(
                team: teams[i],
                schoolName: schoolNames[teams[i].schoolId],
              ),
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16, 12, 16, bottomGap),
              itemCount: teams.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (_, i) => TeamListTile(
                team: teams[i],
                schoolName: schoolNames[teams[i].schoolId],
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
          hintText: 'Buscar por nombre, categoría o entrenador...',
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

// Chip horizontal scrollable de escuelas + chip "Todas" para limpiar el filtro.
class _SchoolFilterBar extends StatelessWidget {
  final int? selectedSchoolId;
  final AsyncValue<List<School>> schoolsAsync;
  final ValueChanged<int?> onChanged;

  const _SchoolFilterBar({
    required this.selectedSchoolId,
    required this.schoolsAsync,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final schools = schoolsAsync.value ?? const <School>[];
    if (schools.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        children: [
          _FilterChip(
            label: 'Todas',
            selected: selectedSchoolId == null,
            onTap: () => onChanged(null),
          ),
          for (final s in schools)
            if (s.id != null) ...[
              const SizedBox(width: 8),
              _FilterChip(
                label: s.name,
                selected: selectedSchoolId == s.id,
                onTap: () => onChanged(s.id),
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
                Icons.groups_rounded,
                color: AppColors.accentDark,
                size: 48,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Aún no hay equipos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Crea el primero con el botón “Nuevo equipo”.',
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
