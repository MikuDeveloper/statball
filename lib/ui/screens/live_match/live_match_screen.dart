import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/global/live_match_provider.dart';
import 'package:statball/app/providers/global/matches_players_provider.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

import 'widgets/live_capture_panel.dart';
import 'widgets/live_match_sidebar.dart';
import 'widgets/live_match_topbar.dart';

// ════════════════════════════════════════════════════════════════════════════
//  LIVE MATCH SCREEN — captura en vivo de eventos durante un partido.
//
//  Layout desktop/tablet: sidebar fijo 200px (no colapsable) + panel derecho.
//  El sidebar contiene la lista de jugadores del partido (matches_players).
//  El panel contiene el form de captura de eventos por jugador seleccionado.
//
//  Estado UI: liveMatchProvider (family por matchId). NO persiste entre sesiones.
// ════════════════════════════════════════════════════════════════════════════
class LiveMatchScreen extends ConsumerStatefulWidget {
  const LiveMatchScreen({super.key, required this.matchId});

  final int matchId;

  @override
  ConsumerState<LiveMatchScreen> createState() => _LiveMatchScreenState();
}

class _LiveMatchScreenState extends ConsumerState<LiveMatchScreen>
    with SnackbarsMixin {
  @override
  Widget build(BuildContext context) {
    final matchesPlayersAsync = ref.watch(
      matchesPlayersProvider(widget.matchId),
    );

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          // ── Top bar (fuera del scroll) ─────────────────────────────────
          LiveMatchTopBar(matchId: widget.matchId),

          // ── Body: sidebar + panel ──────────────────────────────────────
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sidebar fijo 200px
                SizedBox(
                  width: 200,
                  child: matchesPlayersAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Error al cargar jugadores:\n$e',
                          style: const TextStyle(
                            color: AppColors.error,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    data: (players) => LiveMatchSidebar(
                      matchId: widget.matchId,
                      players: players,
                    ),
                  ),
                ),

                // Divider vertical
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: AppColors.cardBorder,
                ),

                // Panel de captura
                Expanded(child: LiveCapturePanel(matchId: widget.matchId)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
