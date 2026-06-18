import 'package:flutter/material.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/domain/models/positions_stats_config/positions_stats_config.dart';

// ─── EventDetailsForm ─────────────────────────────────────────────────────────
// Renderiza los detalles opcionales de un tipo de evento dado.
//   • type == 'boolean' → FilterChip (toggle on/off)
//   • type == 'enum'    → fila de chips segmentados (radio)
// Los valores actuales vienen de [details]; los cambios se notifican vía callbacks.
class EventDetailsForm extends StatelessWidget {
  const EventDetailsForm({
    super.key,
    required this.detailFields,
    required this.details,
    required this.onToggleBool,
    required this.onSetEnum,
  });

  final Map<String, EventDetailField> detailFields;
  final Map<String, dynamic> details;
  final ValueChanged<String> onToggleBool;
  final void Function(String key, String value) onSetEnum;

  @override
  Widget build(BuildContext context) {
    if (detailFields.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: detailFields.entries.map((entry) {
        final key = entry.key;
        final field = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: field.type == 'boolean'
              ? _BoolField(
                  fieldKey: key,
                  label: field.label,
                  value: details[key] as bool? ?? false,
                  onToggle: () => onToggleBool(key),
                )
              : _EnumField(
                  fieldKey: key,
                  label: field.label,
                  options: field.options,
                  selected: details[key] as String?,
                  onSelect: (v) => onSetEnum(key, v),
                ),
        );
      }).toList(),
    );
  }
}

// ── Boolean field ─────────────────────────────────────────────────────────────
class _BoolField extends StatelessWidget {
  const _BoolField({
    required this.fieldKey,
    required this.label,
    required this.value,
    required this.onToggle,
  });

  final String fieldKey;
  final String label;
  final bool value;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: value ? AppColors.accentDark : AppColors.textSecondary,
          fontWeight: value ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
      selected: value,
      onSelected: (_) => onToggle(),
      selectedColor: AppColors.accentSurface,
      checkmarkColor: AppColors.accentDark,
      side: BorderSide(
        color: value ? AppColors.accentDark : AppColors.cardBorder,
      ),
      backgroundColor: AppColors.bgLight,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      visualDensity: VisualDensity.compact,
      showCheckmark: true,
    );
  }
}

// ── Enum field (segmented chips) ──────────────────────────────────────────────
class _EnumField extends StatelessWidget {
  const _EnumField({
    required this.fieldKey,
    required this.label,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final String fieldKey;
  final String label;
  final List<String> options;
  final String? selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6,
          children: options.map((opt) {
            final isSelected = selected == opt;
            return GestureDetector(
              onTap: () => onSelect(opt),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.accentSurface
                      : AppColors.bgLight,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.accentDark
                        : AppColors.cardBorder,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  opt,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.accentDark
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
