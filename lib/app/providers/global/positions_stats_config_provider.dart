import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/domain/models/positions_stats_config/positions_stats_config.dart';

part 'positions_stats_config_provider.g.dart';

// keepAlive: el JSON no cambia en runtime — se carga una vez.
@Riverpod(keepAlive: true)
Future<PositionsStatsConfig> positionsStatsConfig(Ref ref) async {
  final raw = await rootBundle.loadString(
    'assets/config/positions_stats_config.json',
  );
  final json = jsonDecode(raw) as Map<String, dynamic>;
  return PositionsStatsConfig.fromJson(json);
}
