import 'package:flutter/material.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/domain/models/positions_stats_config/positions_stats_config.dart';

// ─── EventTypeGrid ────────────────────────────────────────────────────────────
// Grid de tiles para seleccionar el tipo de evento a capturar.
// Los tipos vienen del positions_stats_config.json (event_types keys).
// Máximo 7 tipos activos: gol, asistencia, pase, tiro, duelo, centro, recuperacion.
class EventTypeGrid extends StatelessWidget {
  const EventTypeGrid({
    super.key,
    required this.eventTypes,
    required this.selectedType,
    required this.onSelect,
  });

  final Map<String, EventTypeConfig> eventTypes;
  final String? selectedType;
  final ValueChanged<String> onSelect;

  // Orden fijo de presentación
  static const _order = [
    'gol',
    'asistencia',
    'pase',
    'tiro',
    'duelo',
    'centro',
    'recuperacion',
  ];

  static const _icons = <String, IconData>{
    'gol': Icons.sports_soccer_rounded,
    'asistencia': Icons.handshake_rounded,
    'pase': Icons.swap_horiz_rounded,
    'tiro': Icons.gps_fixed_rounded,
    'duelo': Icons.people_rounded,
    'centro': Icons.alt_route_rounded,
    'recuperacion': Icons.shield_rounded,
  };

  @override
  Widget build(BuildContext context) {
    // Construye lista en el orden fijo, omitiendo tipos no presentes en config
    final tiles = _order
        .where((k) => eventTypes.containsKey(k))
        .map((k) => (key: k, config: eventTypes[k]!))
        .toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.4,
      ),
      itemCount: tiles.length,
      itemBuilder: (_, i) {
        final tile = tiles[i];
        final isSelected = selectedType == tile.key;
        return _EventTile(
          typeKey: tile.key,
          label: tile.config.label,
          icon: _icons[tile.key] ?? Icons.circle_outlined,
          isSelected: isSelected,
          onTap: () => onSelect(tile.key),
        );
      },
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({
    required this.typeKey,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String typeKey;
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentSurface : AppColors.bgLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.accentDark : AppColors.cardBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.accentDark : AppColors.textMuted,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? AppColors.accentDark
                    : AppColors.textSecondary,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
