import 'package:flutter/foundation.dart' show immutable;

// ════════════════════════════════════════════════════════════════════════════
//  PositionsStatsConfig — modelo inmutable que parsea
//  assets/config/positions_stats_config.json. No usa freezed/json_serializable
//  porque el JSON contiene claves de metadatos (_nota, _readme, etc.) que
//  requieren filtrado manual. Se carga una sola vez via positionsStatsConfigProvider.
// ════════════════════════════════════════════════════════════════════════════

@immutable
class ZoneConfig {
  const ZoneConfig({required this.code, required this.label});
  final String code;
  final String label;

  factory ZoneConfig.fromJson(Map<String, dynamic> json) => ZoneConfig(
    code: json['code'] as String,
    label: json['label'] as String,
  );
}

@immutable
class StatFieldConfig {
  const StatFieldConfig({required this.key, required this.label});
  final String key;
  final String label;

  factory StatFieldConfig.fromJson(Map<String, dynamic> json) => StatFieldConfig(
    key: json['key'] as String,
    label: json['label'] as String,
  );
}

@immutable
class PositionTechConfig {
  const PositionTechConfig({
    required this.label,
    required this.short,
    required this.fields,
  });
  final String label;
  final String short;
  final List<StatFieldConfig> fields;

  factory PositionTechConfig.fromJson(Map<String, dynamic> json) =>
      PositionTechConfig(
        label: json['label'] as String,
        short: json['short'] as String,
        fields: (json['fields'] as List)
            .map((e) => StatFieldConfig.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

@immutable
class EventDetailField {
  const EventDetailField({
    required this.type,
    required this.label,
    required this.options,
  });
  final String type; // 'boolean' | 'enum'
  final String label;
  final List<String> options; // vacío para boolean

  factory EventDetailField.fromJson(Map<String, dynamic> json) =>
      EventDetailField(
        type: json['type'] as String,
        label: json['label'] as String,
        options: (json['options'] as List? ?? const [])
            .map((e) => e as String)
            .toList(),
      );
}

@immutable
class EventTypeConfig {
  const EventTypeConfig({
    required this.label,
    required this.efectividad,
    required this.details,
  });
  final String label;
  final String efectividad;
  final Map<String, EventDetailField> details;

  factory EventTypeConfig.fromJson(Map<String, dynamic> json) {
    final rawDetails = json['details'] as Map<String, dynamic>? ?? {};
    final details = <String, EventDetailField>{};
    for (final entry in rawDetails.entries) {
      if (!entry.key.startsWith('_')) {
        details[entry.key] =
            EventDetailField.fromJson(entry.value as Map<String, dynamic>);
      }
    }
    return EventTypeConfig(
      label: json['label'] as String,
      efectividad: json['efectividad'] as String? ?? 'medible',
      details: details,
    );
  }
}

@immutable
class PositionsStatsConfig {
  const PositionsStatsConfig({
    required this.ratingScale,
    required this.locationZones,
    required this.statsPhysics,
    required this.statsQual,
    required this.statsTech,
    required this.eventTypes,
  });

  final Map<String, int> ratingScale;
  final List<ZoneConfig> locationZones;
  final List<StatFieldConfig> statsPhysics;
  final List<StatFieldConfig> statsQual;
  final Map<String, PositionTechConfig> statsTech;
  final Map<String, EventTypeConfig> eventTypes;

  factory PositionsStatsConfig.fromJson(Map<String, dynamic> json) {
    // rating_scale — filtra claves de metadatos
    final rawRating = json['rating_scale'] as Map<String, dynamic>;
    final ratingScale = <String, int>{};
    for (final e in rawRating.entries) {
      if (!e.key.startsWith('_')) ratingScale[e.key] = e.value as int;
    }

    // location_zones.zones
    final locationZones = (json['location_zones']['zones'] as List)
        .map((e) => ZoneConfig.fromJson(e as Map<String, dynamic>))
        .toList();

    // stats_physics.fields
    final statsPhysics = (json['stats_physics']['fields'] as List)
        .map((e) => StatFieldConfig.fromJson(e as Map<String, dynamic>))
        .toList();

    // stats_qual.fields
    final statsQual = (json['stats_qual']['fields'] as List)
        .map((e) => StatFieldConfig.fromJson(e as Map<String, dynamic>))
        .toList();

    // stats_tech — filtra claves de metadatos
    final rawTech = json['stats_tech'] as Map<String, dynamic>;
    final statsTech = <String, PositionTechConfig>{};
    for (final e in rawTech.entries) {
      if (!e.key.startsWith('_')) {
        statsTech[e.key] =
            PositionTechConfig.fromJson(e.value as Map<String, dynamic>);
      }
    }

    // event_types — filtra claves de metadatos
    final rawEvents = json['event_types'] as Map<String, dynamic>;
    final eventTypes = <String, EventTypeConfig>{};
    for (final e in rawEvents.entries) {
      if (!e.key.startsWith('_')) {
        eventTypes[e.key] =
            EventTypeConfig.fromJson(e.value as Map<String, dynamic>);
      }
    }

    return PositionsStatsConfig(
      ratingScale: ratingScale,
      locationZones: locationZones,
      statsPhysics: statsPhysics,
      statsQual: statsQual,
      statsTech: statsTech,
      eventTypes: eventTypes,
    );
  }
}
