import 'dart:io';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/domain/index.dart' show GameMatchRepository, GameMatch;
import 'package:statball/infrastructure/index.dart' show GameMatchApiException;

class GameMatchApi implements GameMatchRepository {
  final _log = Logger('GameMatchApi');
  final _supabase = Supabase.instance.client;

  static const _table = 'matches';

  @override
  Future<List<GameMatch>> getAll() async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .order('date', ascending: false);
      return (data as List)
          .map((e) => GameMatch.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException(_mapPgCode(e));
    } on SocketException {
      throw GameMatchApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException('unknow_error');
    }
  }

  @override
  Future<GameMatch> getById(int id) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('id', id)
          .maybeSingle();
      if (data == null) throw GameMatchApiException('not_found');
      return GameMatch.fromJson(data);
    } on GameMatchApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException(_mapPgCode(e));
    } on SocketException {
      throw GameMatchApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException('unknow_error');
    }
  }

  @override
  Future<GameMatch> create(GameMatch match) async {
    _ensureDifferentTeams(match);
    try {
      final payload = _serialize(match)..remove('id');
      final data = await _supabase
          .from(_table)
          .insert(payload)
          .select()
          .single();
      return GameMatch.fromJson(data);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException(_mapPgCode(e));
    } on SocketException {
      throw GameMatchApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException('unknow_error');
    }
  }

  @override
  Future<GameMatch> update(GameMatch match) async {
    _ensureDifferentTeams(match);
    try {
      if (match.id == null) throw GameMatchApiException('not_found');
      final payload = _serialize(match)..remove('id');
      final data = await _supabase
          .from(_table)
          .update(payload)
          .eq('id', match.id!)
          .select()
          .single();
      return GameMatch.fromJson(data);
    } on GameMatchApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException(_mapPgCode(e));
    } on SocketException {
      throw GameMatchApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException('unknow_error');
    }
  }

  @override
  Future<int> autoInitializeMatchPlayers(int matchId) async {
    try {
      final result = await _supabase.rpc<dynamic>(
        'auto_initialize_match_players',
        params: {'p_match_id': matchId},
      );
      final n = (result as num?)?.toInt() ?? 0;
      _log.info('Auto-cargados $n jugadores en el match $matchId');
      return n;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException(_mapPgCode(e));
    } on SocketException {
      throw GameMatchApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException('unknow_error');
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _supabase.from(_table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException(_mapPgCode(e));
    } on SocketException {
      throw GameMatchApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw GameMatchApiException('unknow_error');
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  // Validación de negocio: local y visitor deben ser equipos distintos.
  void _ensureDifferentTeams(GameMatch m) {
    if (m.localTeamId == m.visitorTeamId) {
      throw GameMatchApiException('same_team');
    }
  }

  // Postgres timestamptz acepta ISO8601 directamente, así que el toJson
  // default sirve. removeWhere null para no sobreescribir columnas en update.
  Map<String, dynamic> _serialize(GameMatch m) {
    final json = m.toJson();
    // toIso8601String mantiene la hora local; Postgres lo convierte a UTC al
    // almacenar y nos devuelve UTC al leer.
    json['date'] = m.date.toUtc().toIso8601String();
    json.removeWhere((_, v) => v == null);
    return json;
  }

  String _mapPgCode(PostgrestException e) {
    return switch (e.code) {
      '23503' => 'has_associations',
      '42501' => 'permission_denied',
      _ => 'database_error',
    };
  }
}
