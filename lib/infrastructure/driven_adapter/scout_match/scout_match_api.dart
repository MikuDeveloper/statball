import 'dart:io';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/domain/index.dart'
    show ScoutMatchRepository, ScoutMatch;
import 'package:statball/infrastructure/index.dart' show ScoutMatchApiException;

class ScoutMatchApi implements ScoutMatchRepository {
  final _log = Logger('ScoutMatchApi');
  final _supabase = Supabase.instance.client;

  static const _table = 'scouts_matches';

  @override
  Future<List<ScoutMatch>> getByMatch(int matchId) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('match_id', matchId)
          .order('id', ascending: true);
      return (data as List)
          .map((e) => ScoutMatch.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw ScoutMatchApiException(_mapPgCode(e));
    } on SocketException {
      throw ScoutMatchApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw ScoutMatchApiException('unknow_error');
    }
  }

  @override
  Future<ScoutMatch> create(ScoutMatch scoutMatch) async {
    try {
      // id es serial; lo genera Postgres. Filtramos nulls defensivamente.
      final payload = scoutMatch.toJson()..remove('id');
      payload.removeWhere((_, v) => v == null);
      final data = await _supabase
          .from(_table)
          .insert(payload)
          .select()
          .single();
      return ScoutMatch.fromJson(data);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw ScoutMatchApiException(_mapPgCode(e));
    } on SocketException {
      throw ScoutMatchApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw ScoutMatchApiException('unknow_error');
    }
  }

  @override
  Future<ScoutMatch> update(ScoutMatch scoutMatch) async {
    try {
      if (scoutMatch.id == null) throw ScoutMatchApiException('not_found');
      final payload = scoutMatch.toJson()..remove('id');
      payload.removeWhere((_, v) => v == null);
      final data = await _supabase
          .from(_table)
          .update(payload)
          .eq('id', scoutMatch.id!)
          .select()
          .single();
      return ScoutMatch.fromJson(data);
    } on ScoutMatchApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw ScoutMatchApiException(_mapPgCode(e));
    } on SocketException {
      throw ScoutMatchApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw ScoutMatchApiException('unknow_error');
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _supabase.from(_table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw ScoutMatchApiException(_mapPgCode(e));
    } on SocketException {
      throw ScoutMatchApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw ScoutMatchApiException('unknow_error');
    }
  }

  String _mapPgCode(PostgrestException e) {
    return switch (e.code) {
      '23505' => 'already_assigned', // unique_violation (si se añade índice)
      '42501' => 'permission_denied',
      _ => 'database_error',
    };
  }
}
