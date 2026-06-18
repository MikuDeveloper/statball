import 'package:flutter/material.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/domain/models/positions_stats_config/positions_stats_config.dart';

// ─── ZoneGrid3x3 ─────────────────────────────────────────────────────────────
// Grid 3×3 de zonas del campo. Las zonas vienen del config JSON (location_zones).
// Renderiza en filas de 3, seleccionando la zona activa en verde.
class ZoneGrid3x3 extends StatelessWidget {
  const ZoneGrid3x3({
    super.key,
    required this.zones,
    required this.selectedZone,
    required this.onSelect,
  });

  final List<ZoneConfig> zones;
  final String? selectedZone;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    // El grid siempre es 3 columnas; si hay más/menos de 9 aún funciona.
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        childAspectRatio: 1.6,
      ),
      itemCount: zones.length,
      itemBuilder: (_, i) {
        final zone = zones[i];
        final isSelected = selectedZone == zone.code;
        return _ZoneTile(
          zone: zone,
          isSelected: isSelected,
          onTap: () => onSelect(zone.code),
        );
      },
    );
  }
}

class _ZoneTile extends StatelessWidget {
  const _ZoneTile({
    required this.zone,
    required this.isSelected,
    required this.onTap,
  });

  final ZoneConfig zone;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentDark : AppColors.bgLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.accentDark : AppColors.cardBorder,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              zone.code,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: isSelected ? AppColors.onAccent : AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              zone.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 9,
                color: isSelected
                    ? AppColors.onAccent
                    : AppColors.textSecondary,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
