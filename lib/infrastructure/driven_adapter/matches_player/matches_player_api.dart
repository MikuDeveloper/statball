import 'dart:io';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/app/global/enums.dart' show EvaluationStatus;
import 'package:statball/domain/models/matches_player/matches_player.dart';
import 'package:statball/domain/models/matches_player/repository/matches_player_repository.dart';
import 'package:statball/infrastructure/helpers/exceptions/matches_player_api_exception.dart';

class MatchesPlayerApi implements MatchesPlayerRepository {
  final _log = Logger('MatchesPlayerApi');
  final _supabase = Supabase.instance.client;

  static const _table = 'matches_players';

  @override
  Future<List<MatchesPlayer>> getByMatch(int matchId) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('match_id', matchId)
          .order('id', ascending: true);
      return (data as List)
          .map((e) => MatchesPlayer.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw MatchesPlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw MatchesPlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw MatchesPlayerApiException('unknow_error');
    }
  }

  @override
  Future<MatchesPlayer> create(MatchesPlayer player) async {
    try {
      final payload = player.toJson()..remove('id');
      payload.removeWhere((_, v) => v == null);
      final data = await _supabase
          .from(_table)
          .insert(payload)
          .select()
          .single();
      return MatchesPlayer.fromJson(data);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw MatchesPlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw MatchesPlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw MatchesPlayerApiException('unknow_error');
    }
  }

  @override
  Future<MatchesPlayer> update(MatchesPlayer player) async {
    try {
      if (player.id == null) throw MatchesPlayerApiException('not_found');
      final payload = player.toJson()..remove('id');
      payload.removeWhere((_, v) => v == null);
      final data = await _supabase
          .from(_table)
          .update(payload)
          .eq('id', player.id!)
          .select()
          .single();
      return MatchesPlayer.fromJson(data);
    } on MatchesPlayerApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw MatchesPlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw MatchesPlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw MatchesPlayerApiException('unknow_error');
    }
  }

  @override
  Future<MatchesPlayer> updateStatus(int id, EvaluationStatus status) async {
    try {
      final data = await _supabase
          .from(_table)
          .update({'evaluation_status': status.dbValue})
          .eq('id', id)
          .select()
          .single();
      return MatchesPlayer.fromJson(data);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw MatchesPlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw MatchesPlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw MatchesPlayerApiException('unknow_error');
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _supabase.from(_table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw MatchesPlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw MatchesPlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw MatchesPlayerApiException('unknow_error');
    }
  }

  String _mapPgCode(PostgrestException e) {
    return switch (e.code) {
      '23505' => 'already_exists',
      '42501' => 'permission_denied',
      _ => 'database_error',
    };
  }
}
