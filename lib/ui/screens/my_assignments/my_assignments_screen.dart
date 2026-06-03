import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/global/game_matches_provider.dart';
import 'package:statball/app/providers/global/my_assignments_provider.dart';
import 'package:statball/app/providers/global/teams_provider.dart';
// Sin `show` para que GameMatchX (relativeLabel/isUpcoming) entre en scope.
import 'package:statball/domain/index.dart';

// ════════════════════════════════════════════════════════════════════════════
//  MY ASSIGNMENTS SCREEN — "Mi visoría"
//  Muestra las visorías asignadas al scout del usuario autenticado.
//  Tabs: Próximas (default) / Pasadas.
// ════════════════════════════════════════════════════════════════════════════
class MyAssignmentsScreen extends ConsumerStatefulWidget {
  const MyAssignmentsScreen({super.key});

  @override
  ConsumerState<MyAssignmentsScreen> createState() =>
      _MyAssignmentsScreenState();
}

class _MyAssignmentsScreenState extends ConsumerState<MyAssignmentsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(myAssignmentsProvider);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        surfaceTintColor: AppColors.bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text(
          'Mi visoría',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Actualizar',
            icon: const Icon(Icons.refresh_rounded, color: AppColors.textMuted),
            onPressed: () => ref.read(myAssignmentsProvider.notifier).refresh(),
          ),
        ],
        bottom: TabBar(
          controller: _tabs,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.textMuted,
          indicatorColor: AppColors.accentDark,
          indicatorWeight: 2.5,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13.5,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13.5,
          ),
          tabs: const [
            Tab(text: 'Próximas'),
            Tab(text: 'Pasadas'),
          ],
        ),
      ),
      body: stateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorState(message: e.toString()),
        data: (_) {
          final notifier = ref.read(myAssignmentsProvider.notifier);
          return TabBarView(
            controller: _tabs,
            children: [
              _AssignmentList(
                assignments: notifier.upcoming,
                tab: _Tab.upcoming,
              ),
              _AssignmentList(assignments: notifier.past, tab: _Tab.past),
            ],
          );
        },
      ),
    );
  }
}

enum _Tab { upcoming, past }

// ─── _AssignmentList ─────────────────────────────────────────────────────────
class _AssignmentList extends ConsumerWidget {
  final List<ScoutMatch> assignments;
  final _Tab tab;

  const _AssignmentList({required this.assignments, required this.tab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (assignments.isEmpty) {
      return _EmptyState(tab: tab);
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: assignments.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final sm = assignments[i];
        final match = ref.read(gameMatchesProvider.notifier).byId(sm.matchId);
        final teams = ref.read(teamsProvider).value ?? const [];
        final local = match != null
            ? _teamById(teams, match.localTeamId)
            : null;
        final visitor = match != null
            ? _teamById(teams, match.visitorTeamId)
            : null;
        return _AssignmentCard(
          scoutMatch: sm,
          match: match,
          local: local,
          visitor: visitor,
        );
      },
    );
  }

  Team? _teamById(List<Team> teams, String id) {
    for (final t in teams) {
      if (t.id == id) return t;
    }
    return null;
  }
}

// ─── _AssignmentCard ─────────────────────────────────────────────────────────
class _AssignmentCard extends StatelessWidget {
  final ScoutMatch scoutMatch;
  final GameMatch? match;
  final Team? local;
  final Team? visitor;

  const _AssignmentCard({
    required this.scoutMatch,
    required this.match,
    required this.local,
    required this.visitor,
  });

  @override
  Widget build(BuildContext context) {
    final upcoming = match?.isUpcoming ?? false;
    final accentColor = upcoming ? AppColors.accentDark : AppColors.textMuted;

    return GestureDetector(
      onTap: match?.id == null
          ? null
          : () {
              // TODO(deliverable-9): migrar a /live-match cuando esté implementado
              GameMatchFormRoute(id: match!.id).push<void>(context);
            },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorder, width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header: fecha relativa + ícono ─────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
              child: Row(
                children: [
                  Icon(
                    upcoming ? Icons.event_rounded : Icons.history_rounded,
                    size: 14,
                    color: accentColor,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      match?.relativeLabel ?? 'Fecha desconocida',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: accentColor,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            const Divider(height: 1, color: AppColors.divider),
            const SizedBox(height: 10),

            // ── Body: LOCAL vs VISIT ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(child: _TeamSide(team: local, isLocal: true)),
                  const SizedBox(width: 10),
                  const Text(
                    'vs',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textMuted,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: _TeamSide(team: visitor, isLocal: false)),
                ],
              ),
            ),

            // ── Footer: notes (si no está vacío) ──────────────────────────
            if (scoutMatch.notes.trim().isNotEmpty) ...[
              const SizedBox(height: 10),
              const Divider(height: 1, color: AppColors.divider),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.notes_rounded,
                      size: 14,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        scoutMatch.notes,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else
              const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

// ─── _TeamSide ────────────────────────────────────────────────────────────────
class _TeamSide extends StatelessWidget {
  final Team? team;
  final bool isLocal;
  const _TeamSide({required this.team, required this.isLocal});

  @override
  Widget build(BuildContext context) {
    final label = isLocal ? 'LOCAL' : 'VISIT';
    final labelColor = isLocal ? AppColors.accentDark : AppColors.accentAlt;
    return Column(
      crossAxisAlignment: isLocal
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            color: labelColor,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          team?.name ?? 'Equipo desconocido',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: isLocal ? TextAlign.start : TextAlign.end,
          style: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.2,
          ),
        ),
        if (team?.category.isNotEmpty == true) ...[
          const SizedBox(height: 1),
          Text(
            team!.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: isLocal ? TextAlign.start : TextAlign.end,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ],
    );
  }
}

// ─── Empty states ────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final _Tab tab;
  const _EmptyState({required this.tab});

  @override
  Widget build(BuildContext context) {
    final (icon, message) = switch (tab) {
      _Tab.upcoming => (
        Icons.event_outlined,
        'No tienes visorías próximas asignadas.',
      ),
      _Tab.past => (Icons.history_rounded, 'No hay visorías pasadas aún.'),
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 52, color: AppColors.textMuted),
            const SizedBox(height: 14),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textMuted,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Error al cargar visorías: $message',
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.error),
        ),
      ),
    );
  }
}
