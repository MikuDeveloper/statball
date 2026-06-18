import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/global/live_match_provider.dart';
import 'package:statball/app/providers/global/matches_players_provider.dart';
import 'package:statball/app/providers/global/players_provider.dart';
import 'package:statball/app/providers/global/positions_stats_config_provider.dart';
import 'package:statball/domain/models/positions_stats_config/positions_stats_config.dart';
import 'package:statball/infrastructure/helpers/exceptions/match_event_api_exception.dart';

import 'event_details_form.dart';
import 'event_type_grid.dart';
import 'quick_note_field.dart';
import 'zone_grid_3x3.dart';

// ─── LiveCapturePanel ─────────────────────────────────────────────────────────
// Panel derecho de la pantalla de live match. Si no hay jugador seleccionado
// muestra un estado vacío; si hay jugador muestra el formulario de captura.
//
// El matchId lo lee del liveMatchProvider activo — el padre siempre construye
// la pantalla con un matchId específico así que el watch devuelve el correcto.
// Para evitar pasar matchId por árbol hacemos que el panel lo obtenga del
// provider: el primer liveMatchProvider que exista en el árbol es el nuestro.
//
// NOTA: el panel recibe matchId explícitamente para no depender de un "primero
// que exista" en el árbol de providers.
class LiveCapturePanel extends ConsumerStatefulWidget {
  const LiveCapturePanel({super.key, required this.matchId});

  final int matchId;

  @override
  ConsumerState<LiveCapturePanel> createState() => _LiveCapturePanelState();
}

class _LiveCapturePanelState extends ConsumerState<LiveCapturePanel> {
  bool _saving = false;

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await ref.read(liveMatchProvider(widget.matchId).notifier).saveEvent();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Evento guardado'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } on ArgumentError catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } on MatchEventApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: AppColors.error),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final liveState = ref.watch(liveMatchProvider(widget.matchId));
    final configAsync = ref.watch(positionsStatsConfigProvider);

    if (liveState.selectedPlayerId == null) {
      return const _EmptyPanel();
    }

    return configAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text(
          'Error cargando config:\n$e',
          style: const TextStyle(color: AppColors.error, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
      data: (config) => _PanelContent(
        matchId: widget.matchId,
        liveState: liveState,
        config: config as PositionsStatsConfig,
        saving: _saving,
        onSave: _save,
      ),
    );
  }
}

// ─── Empty state ───────────────────────────────────────────────────────────────
class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.person_search_rounded,
              size: 64,
              color: AppColors.cardBorder,
            ),
            SizedBox(height: 16),
            Text(
              'Selecciona un jugador del sidebar\npara capturar eventos',
              textAlign: TextAlign.center,
              style: TextStyle(
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

// ─── Panel con jugador seleccionado ───────────────────────────────────────────
class _PanelContent extends ConsumerWidget {
  const _PanelContent({
    required this.matchId,
    required this.liveState,
    required this.config,
    required this.saving,
    required this.onSave,
  });

  final int matchId;
  final LiveMatchData liveState;
  final PositionsStatsConfig config;
  final bool saving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(liveMatchProvider(matchId).notifier);

    // Nombre del jugador seleccionado
    final players = ref.watch(playersProvider).value ?? const [];
    final matchesPlayers =
        ref.watch(matchesPlayersProvider(matchId)).value ?? const [];
    final mp = matchesPlayers
        .where((p) => p.id == liveState.selectedPlayerId)
        .firstOrNull;
    final playerData = mp != null
        ? players.where((p) => p.id == mp.playerId).firstOrNull
        : null;
    final playerName = playerData?.fullName ?? 'Jugador';

    // Detalles del tipo de evento seleccionado
    final selectedTypeConfig = liveState.selectedEventType != null
        ? config.eventTypes[liveState.selectedEventType]
        : null;
    final hasDetails =
        selectedTypeConfig != null && selectedTypeConfig.details.isNotEmpty;
    final showZone = liveState.selectedEventType != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Header jugador ───────────────────────────────────────────────
        _PanelHeader(
          playerName: playerName,
          position: mp?.position.label ?? '',
          minute: liveState.currentMinute,
        ),

        // ── Contenido scrollable ─────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tipo de evento
                _SectionLabel(label: 'Tipo de evento'),
                const SizedBox(height: 8),
                EventTypeGrid(
                  eventTypes: config.eventTypes,
                  selectedType: liveState.selectedEventType,
                  onSelect: notifier.selectEventType,
                ),

                // Detalles del evento (solo si hay)
                if (hasDetails && selectedTypeConfig != null) ...[
                  const SizedBox(height: 16),
                  _SectionLabel(label: 'Detalles'),
                  const SizedBox(height: 8),
                  EventDetailsForm(
                    detailFields: selectedTypeConfig.details,
                    details: liveState.eventDetails,
                    onToggleBool: notifier.toggleDetailBool,
                    onSetEnum: notifier.setDetailEnum,
                  ),
                ],

                // Zona del campo (solo si hay tipo seleccionado)
                if (showZone) ...[
                  const SizedBox(height: 16),
                  _SectionLabel(label: 'Zona del campo'),
                  const SizedBox(height: 8),
                  ZoneGrid3x3(
                    zones: config.locationZones,
                    selectedZone: liveState.selectedZone,
                    onSelect: notifier.selectZone,
                  ),
                ],

                const SizedBox(height: 16),

                // Nota rápida
                QuickNoteField(
                  value: liveState.quickNote,
                  onChanged: notifier.setQuickNote,
                ),
              ],
            ),
          ),
        ),

        // ── Pie: botones ─────────────────────────────────────────────────
        const Divider(height: 1, color: AppColors.cardBorder),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Limpiar
              OutlinedButton(
                onPressed: notifier.clearEventForm,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  side: const BorderSide(color: AppColors.cardBorder),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Limpiar'),
              ),
              const SizedBox(width: 10),

              // Guardar evento
              FilledButton(
                onPressed: saving ? null : onSave,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accentDark,
                  foregroundColor: AppColors.onAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: saving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.onAccent,
                        ),
                      )
                    : const Text(
                        'Guardar evento',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader({
    required this.playerName,
    required this.position,
    required this.minute,
  });

  final String playerName;
  final String position;
  final int minute;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(bottom: BorderSide(color: AppColors.cardBorder)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.person_rounded,
            size: 18,
            color: AppColors.accentDark,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playerName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (position.isNotEmpty)
                  Text(
                    position,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.bgLight,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Text(
              "Min. $minute'",
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: AppColors.textMuted,
        letterSpacing: 0.8,
      ),
    );
  }
}
