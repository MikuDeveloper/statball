import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/enums.dart'
    show FootPreference, PlayerPosition;
import 'package:statball/app/providers/global/game_matches_provider.dart';
import 'package:statball/app/providers/global/matches_players_provider.dart';
import 'package:statball/app/providers/global/players_provider.dart';
import 'package:statball/app/providers/global/scouts_provider.dart';
import 'package:statball/app/providers/global/sb_user_data_provider.dart';
import 'package:statball/app/providers/global/teams_provider.dart';
import 'package:statball/domain/models/matches_player/matches_player.dart';
// Import directo del modelo para que la extensión PlayerX.fullName entre en scope.
import 'package:statball/domain/models/player/player.dart';
import 'package:statball/domain/models/team/team.dart';
import 'package:statball/infrastructure/helpers/exceptions/matches_player_api_exception.dart';
import 'package:statball/infrastructure/helpers/exceptions/player_api_exception.dart';

// ════════════════════════════════════════════════════════════════════════════
//  showAddPlayerSheet — bottom sheet con 2 tabs para agregar jugadores a la
//  visoría en vivo: "Catálogo" (buscar y agregar existentes) y "Crear nuevo
//  rápido" (alta mínima en catálogo + alta opcional en el match).
// ════════════════════════════════════════════════════════════════════════════
Future<void> showAddPlayerSheet({
  required BuildContext context,
  required int matchId,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.bgLight,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    builder: (_) => FractionallySizedBox(
      heightFactor: 0.9,
      child: _AddPlayerSheet(matchId: matchId),
    ),
  );
}

class _AddPlayerSheet extends ConsumerStatefulWidget {
  const _AddPlayerSheet({required this.matchId});

  final int matchId;

  @override
  ConsumerState<_AddPlayerSheet> createState() => _AddPlayerSheetState();
}

class _AddPlayerSheetState extends ConsumerState<_AddPlayerSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  // ids de los equipos del partido (para badge + auto-add).
  ({String? local, String? visitor}) get _teamIds {
    final match = ref
        .read(gameMatchesProvider)
        .value
        ?.where((m) => m.id == widget.matchId)
        .firstOrNull;
    return (local: match?.localTeamId, visitor: match?.visitorTeamId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 38,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.cardBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Agregar jugador',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          TabBar(
            controller: _tabs,
            labelColor: AppColors.accentDark,
            unselectedLabelColor: AppColors.textMuted,
            indicatorColor: AppColors.accentDark,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
            tabs: const [
              Tab(text: 'Catálogo'),
              Tab(text: 'Crear nuevo rápido'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _CatalogTab(matchId: widget.matchId, teamIds: _teamIds),
                _CreateTab(matchId: widget.matchId, teamIds: _teamIds),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
//  Tab Catálogo
// ════════════════════════════════════════════════════════════════════════════
class _CatalogTab extends ConsumerStatefulWidget {
  const _CatalogTab({required this.matchId, required this.teamIds});

  final int matchId;
  final ({String? local, String? visitor}) teamIds;

  @override
  ConsumerState<_CatalogTab> createState() => _CatalogTabState();
}

class _CatalogTabState extends ConsumerState<_CatalogTab> {
  String _query = '';

  Future<void> _add(Player player) async {
    if (player.id == null) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(matchesPlayersProvider(widget.matchId).notifier)
          .add(
            MatchesPlayer(
              matchId: widget.matchId,
              playerId: player.id!,
              position: player.defaultPosition,
            ),
          );
      messenger.showSnackBar(
        _snack('${player.fullName} agregado a la visoría', AppColors.success),
      );
    } on MatchesPlayerApiException catch (e) {
      messenger.showSnackBar(_snack(e.message, AppColors.error));
    } catch (_) {
      messenger.showSnackBar(
        _snack('No se pudo agregar el jugador', AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(playersProvider).value ?? const [];
    final teams = ref.watch(teamsProvider).value ?? const [];
    final matchPlayers =
        ref.watch(matchesPlayersProvider(widget.matchId)).value ?? const [];
    final inMatchPlayerIds = matchPlayers.map((p) => p.playerId).toSet();

    final filtered = _query.isEmpty
        ? players
        : players
              .where((p) => p.fullName.toLowerCase().contains(_query))
              .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
            decoration: InputDecoration(
              hintText: 'Buscar por nombre o apellido...',
              prefixIcon: const Icon(Icons.search_rounded, size: 20),
              filled: true,
              fillColor: AppColors.card,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.cardBorder),
              ),
            ),
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? const Center(
                  child: Text(
                    'Sin jugadores en el catálogo',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final p = filtered[i];
                    final teamName = p.teamId == null
                        ? null
                        : teams
                              .where((t) => t.id == p.teamId)
                              .firstOrNull
                              ?.name;
                    final already = inMatchPlayerIds.contains(p.id);
                    return _CatalogRow(
                      player: p,
                      teamName: teamName,
                      alreadyInMatch: already,
                      onAdd: () => _add(p),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _CatalogRow extends StatelessWidget {
  const _CatalogRow({
    required this.player,
    required this.teamName,
    required this.alreadyInMatch,
    required this.onAdd,
  });

  final Player player;
  final String? teamName;
  final bool alreadyInMatch;
  final VoidCallback onAdd;

  String get _initials {
    final fn = player.firstname.trim();
    final ln = player.lastname.trim();
    final a = fn.isNotEmpty ? fn[0] : '';
    final b = ln.isNotEmpty ? ln[0] : '';
    final s = '$a$b'.toUpperCase();
    return s.isEmpty ? '?' : s;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.accentSurface,
            child: Text(
              _initials,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.accentDark,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${teamName ?? 'Sin equipo'} · ${player.defaultPosition.label}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (alreadyInMatch)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.textMuted.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Ya en evaluación',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                ),
              ),
            )
          else
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_rounded, size: 16),
              label: const Text('Agregar'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accentDark,
                foregroundColor: AppColors.onAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
//  Tab Crear nuevo rápido
// ════════════════════════════════════════════════════════════════════════════
class _CreateTab extends ConsumerStatefulWidget {
  const _CreateTab({required this.matchId, required this.teamIds});

  final int matchId;
  final ({String? local, String? visitor}) teamIds;

  @override
  ConsumerState<_CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends ConsumerState<_CreateTab> {
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  FootPreference _foot = FootPreference.derecha;
  bool _basicForces = false;
  PlayerPosition _position = PlayerPosition.mediocentro;
  String? _teamId;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _teamId = widget.teamIds.local; // pre-selecciona el local
  }

  @override
  void dispose() {
    _firstname.dispose();
    _lastname.dispose();
    super.dispose();
  }

  bool get _teamInMatch =>
      _teamId != null &&
      (_teamId == widget.teamIds.local || _teamId == widget.teamIds.visitor);

  Future<void> _save(String scoutId) async {
    final fn = _firstname.text.trim();
    final ln = _lastname.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    if (fn.isEmpty || ln.isEmpty) {
      messenger.showSnackBar(
        _snack('Nombre y apellido son obligatorios', AppColors.error),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final created = await ref
          .read(playersProvider.notifier)
          .create(
            Player(
              firstname: fn,
              lastname: ln,
              preferredFoot: _foot,
              basicForces: _basicForces,
              defaultPosition: _position,
              teamId: _teamId,
              scoutId: scoutId,
            ),
          );

      if (_teamInMatch && created.id != null) {
        await ref
            .read(matchesPlayersProvider(widget.matchId).notifier)
            .add(
              MatchesPlayer(
                matchId: widget.matchId,
                playerId: created.id!,
                position: _position,
              ),
            );
        messenger.showSnackBar(
          _snack(
            '${created.fullName} creado y agregado a la visoría',
            AppColors.success,
          ),
        );
      } else {
        messenger.showSnackBar(
          _snack(
            '${created.fullName} creado en el catálogo (fuera de los equipos del partido)',
            AppColors.info,
          ),
        );
      }
      navigator.pop();
    } on PlayerApiException catch (e) {
      messenger.showSnackBar(_snack(e.message, AppColors.error));
    } on MatchesPlayerApiException catch (e) {
      messenger.showSnackBar(_snack(e.message, AppColors.error));
    } catch (_) {
      messenger.showSnackBar(
        _snack('No se pudo crear el jugador', AppColors.error),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final teams = ref.watch(teamsProvider).value ?? const [];

    // Scout del usuario logueado (scout_id implícito).
    final uid = ref.watch(sbUserDataProvider).value?.id;
    final scouts = ref.watch(scoutsProvider).value ?? const [];
    final myScout = scouts.where((s) => s.userId == uid).firstOrNull;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        _label('NOMBRE *'),
        _textField(_firstname, 'Ej. Andrés'),
        const SizedBox(height: 14),
        _label('APELLIDO *'),
        _textField(_lastname, 'Ej. García'),
        const SizedBox(height: 16),

        _label('PIE PREFERIDO *'),
        const SizedBox(height: 6),
        Row(
          children: [
            for (final f in FootPreference.values) ...[
              Expanded(
                child: _segChip(
                  label: f.label,
                  selected: _foot == f,
                  onTap: () => setState(() => _foot = f),
                ),
              ),
              if (f != FootPreference.values.last) const SizedBox(width: 8),
            ],
          ],
        ),
        const SizedBox(height: 16),

        _label('POSICIÓN PRINCIPAL *'),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in PlayerPosition.values)
              _segChip(
                label: p.label,
                selected: _position == p,
                onTap: () => setState(() => _position = p),
              ),
          ],
        ),
        const SizedBox(height: 16),

        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _basicForces,
          onChanged: (v) => setState(() => _basicForces = v),
          activeThumbColor: AppColors.accentAlt,
          title: const Text(
            'Fuerzas básicas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),

        _label('EQUIPO'),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _teamId,
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.card,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.cardBorder),
            ),
          ),
          items: [
            const DropdownMenuItem<String>(
              value: null,
              child: Text('Sin equipo'),
            ),
            ...teams
                .where((t) => t.id != null)
                .map(
                  (t) => DropdownMenuItem<String>(
                    value: t.id,
                    child: Text(_teamLabel(t), overflow: TextOverflow.ellipsis),
                  ),
                ),
          ],
          onChanged: (v) => setState(() => _teamId = v),
        ),

        if (!_teamInMatch) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.warning.withValues(alpha: 0.35),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: AppColors.warning,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Este jugador no está en los equipos del partido. Quedará '
                    'registrado en el catálogo pero no se agregará a esta visoría.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.warning,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 18),

        if (myScout?.id == null)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            ),
            child: const Text(
              'No tienes un perfil de scout vinculado a tu cuenta. '
              'Pídele a tu coordinador que te vincule para crear jugadores.',
              style: TextStyle(fontSize: 12, color: AppColors.error),
            ),
          )
        else
          SizedBox(
            height: 50,
            child: FilledButton(
              onPressed: _saving ? null : () => _save(myScout!.id!),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accentDark,
                foregroundColor: AppColors.onAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.onAccent,
                      ),
                    )
                  : const Text(
                      'Crear jugador',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
            ),
          ),
      ],
    );
  }

  String _teamLabel(Team t) =>
      t.category.isEmpty ? t.name : '${t.name} · ${t.category}';

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w800,
      color: AppColors.textMuted,
      letterSpacing: 0.6,
    ),
  );

  Widget _textField(TextEditingController c, String hint) => Padding(
    padding: const EdgeInsets.only(top: 6),
    child: TextField(
      controller: c,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.card,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
      ),
    ),
  );

  Widget _segChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentDark : AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.accentDark : AppColors.cardBorder,
            width: selected ? 1.6 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? AppColors.onAccent : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

SnackBar _snack(String msg, Color bg) => SnackBar(
  content: Text(msg, style: const TextStyle(color: Colors.white)),
  backgroundColor: bg,
  behavior: SnackBarBehavior.floating,
);
