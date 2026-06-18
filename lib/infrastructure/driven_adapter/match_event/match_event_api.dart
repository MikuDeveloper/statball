import 'dart:io';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/domain/models/match_event/match_event.dart';
import 'package:statball/domain/models/match_event/repository/match_event_repository.dart';
import 'package:statball/infrastructure/helpers/exceptions/match_event_api_exception.dart';

class MatchEventApi implements MatchEventRepository {
  final _log = Logger('MatchEventApi');
  final _supabase = Supabase.instance.client;

  static const _table = 'matches_events';

  @override
  Future<List<MatchEvent>> getByMatchPlayer(int matchPlayerId) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('match_player_id', matchPlayerId)
          .order('minute', ascending: true);
      return (data as List)
          .map((e) => MatchEvent.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw MatchEventApiException(_mapPgCode(e));
    } on SocketException {
      throw MatchEventApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw MatchEventApiException('unknow_error');
    }
  }

  @override
  Future<MatchEvent> create(MatchEvent event) async {
    try {
      final payload = event.toJson()..remove('id');
      payload.removeWhere((_, v) => v == null);
      final data = await _supabase
          .from(_table)
          .insert(payload)
          .select()
          .single();
      return MatchEvent.fromJson(data);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw MatchEventApiException(_mapPgCode(e));
    } on SocketException {
      throw MatchEventApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw MatchEventApiException('unknow_error');
    }
  }

  String _mapPgCode(PostgrestException e) {
    return switch (e.code) {
      '42501' => 'permission_denied',
      _ => 'database_error',
    };
  }
}
