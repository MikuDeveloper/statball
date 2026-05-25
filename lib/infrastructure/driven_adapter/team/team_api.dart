import 'dart:io';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/domain/index.dart' show TeamRepository, Team;
import 'package:statball/infrastructure/index.dart' show TeamApiException;

class TeamApi implements TeamRepository {
  final _log = Logger('TeamApi');
  final _supabase = Supabase.instance.client;

  static const _table = 'teams';

  @override
  Future<List<Team>> getAll() async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .order('name', ascending: true);
      return (data as List)
          .map((e) => Team.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw TeamApiException(_mapPgCode(e));
    } on SocketException {
      throw TeamApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw TeamApiException('unknow_error');
    }
  }

  @override
  Future<List<Team>> getBySchool(int schoolId) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('school_id', schoolId)
          .order('name', ascending: true);
      return (data as List)
          .map((e) => Team.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw TeamApiException(_mapPgCode(e));
    } on SocketException {
      throw TeamApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw TeamApiException('unknow_error');
    }
  }

  @override
  Future<Team> getById(String id) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('id', id)
          .maybeSingle();
      if (data == null) throw TeamApiException('not_found');
      return Team.fromJson(data);
    } on TeamApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw TeamApiException(_mapPgCode(e));
    } on SocketException {
      throw TeamApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw TeamApiException('unknow_error');
    }
  }

  @override
  Future<Team> create(Team team) async {
    try {
      // Removemos id para que Postgres lo genere via DEFAULT gen_random_uuid()
      final payload = team.toJson()..remove('id');
      final data = await _supabase
          .from(_table)
          .insert(payload)
          .select()
          .single();
      return Team.fromJson(data);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw TeamApiException(_mapPgCode(e));
    } on SocketException {
      throw TeamApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw TeamApiException('unknow_error');
    }
  }

  @override
  Future<Team> update(Team team) async {
    try {
      if (team.id == null) throw TeamApiException('not_found');
      final payload = team.toJson()..remove('id');
      final data = await _supabase
          .from(_table)
          .update(payload)
          .eq('id', team.id!)
          .select()
          .single();
      return Team.fromJson(data);
    } on TeamApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw TeamApiException(_mapPgCode(e));
    } on SocketException {
      throw TeamApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw TeamApiException('unknow_error');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _supabase.from(_table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw TeamApiException(_mapPgCode(e));
    } on SocketException {
      throw TeamApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw TeamApiException('unknow_error');
    }
  }

  // 23503 = foreign_key_violation (players/matches refieren al team).
  String _mapPgCode(PostgrestException e) {
    return switch (e.code) {
      '23503' => 'has_associations',
      '42501' => 'permission_denied',
      _ => 'database_error',
    };
  }
}
