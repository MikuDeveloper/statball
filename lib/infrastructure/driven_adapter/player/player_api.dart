import 'dart:io';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/domain/index.dart' show PlayerRepository, Player;
import 'package:statball/infrastructure/index.dart' show PlayerApiException;

class PlayerApi implements PlayerRepository {
  final _log = Logger('PlayerApi');
  final _supabase = Supabase.instance.client;

  static const _table = 'players';

  @override
  Future<List<Player>> getAll() async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .order('lastname', ascending: true)
          .order('firstname', ascending: true);
      return (data as List)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw PlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException('unknow_error');
    }
  }

  @override
  Future<List<Player>> getByTeam(String teamId) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('team_id', teamId)
          .order('lastname', ascending: true)
          .order('firstname', ascending: true);
      return (data as List)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw PlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException('unknow_error');
    }
  }

  @override
  Future<Player> getById(String id) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('id', id)
          .maybeSingle();
      if (data == null) throw PlayerApiException('not_found');
      return Player.fromJson(data);
    } on PlayerApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw PlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException('unknow_error');
    }
  }

  @override
  Future<Player> create(Player player) async {
    try {
      // id se genera en DB via gen_random_uuid()
      final payload = _serialize(player)..remove('id');
      final data = await _supabase
          .from(_table)
          .insert(payload)
          .select()
          .single();
      return Player.fromJson(data);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw PlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException('unknow_error');
    }
  }

  @override
  Future<Player> update(Player player) async {
    try {
      if (player.id == null) throw PlayerApiException('not_found');
      final payload = _serialize(player)..remove('id');
      final data = await _supabase
          .from(_table)
          .update(payload)
          .eq('id', player.id!)
          .select()
          .single();
      return Player.fromJson(data);
    } on PlayerApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw PlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException('unknow_error');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _supabase.from(_table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException(_mapPgCode(e));
    } on SocketException {
      throw PlayerApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw PlayerApiException('unknow_error');
    }
  }

  // Convierte birthday (DateTime) a 'YYYY-MM-DD' que es lo que espera Postgres
  // para columnas tipo `date`. El default toJson serializa como ISO completo
  // (incluye hora) y Postgres lo aceptaría pero perdemos info al re-leer.
  Map<String, dynamic> _serialize(Player p) {
    final json = p.toJson();
    final birthday = p.birthday;
    final iso =
        '${birthday.year.toString().padLeft(4, '0')}-'
        '${birthday.month.toString().padLeft(2, '0')}-'
        '${birthday.day.toString().padLeft(2, '0')}';
    json['birthday'] = iso;
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
