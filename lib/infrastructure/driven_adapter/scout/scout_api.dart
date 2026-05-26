import 'dart:io';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/domain/index.dart' show ScoutRepository, Scout;
import 'package:statball/infrastructure/index.dart' show ScoutApiException;

class ScoutApi implements ScoutRepository {
  final _log = Logger('ScoutApi');
  final _supabase = Supabase.instance.client;

  static const _table = 'scouts';

  @override
  Future<List<Scout>> getAll() async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .order('lastname', ascending: true)
          .order('name', ascending: true);
      return (data as List)
          .map((e) => Scout.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw ScoutApiException(_mapPgCode(e));
    } on SocketException {
      throw ScoutApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw ScoutApiException('unknow_error');
    }
  }

  @override
  Future<Scout> getById(String id) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('id', id)
          .maybeSingle();
      if (data == null) throw ScoutApiException('not_found');
      return Scout.fromJson(data);
    } on ScoutApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw ScoutApiException(_mapPgCode(e));
    } on SocketException {
      throw ScoutApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw ScoutApiException('unknow_error');
    }
  }

  @override
  Future<Scout> create(Scout scout) async {
    try {
      final payload = _serialize(scout)..remove('id');
      final data = await _supabase
          .from(_table)
          .insert(payload)
          .select()
          .single();
      return Scout.fromJson(data);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw ScoutApiException(_mapPgCode(e));
    } on SocketException {
      throw ScoutApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw ScoutApiException('unknow_error');
    }
  }

  @override
  Future<Scout> update(Scout scout) async {
    try {
      if (scout.id == null) throw ScoutApiException('not_found');
      final payload = _serialize(scout)..remove('id');
      final data = await _supabase
          .from(_table)
          .update(payload)
          .eq('id', scout.id!)
          .select()
          .single();
      return Scout.fromJson(data);
    } on ScoutApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw ScoutApiException(_mapPgCode(e));
    } on SocketException {
      throw ScoutApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw ScoutApiException('unknow_error');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _supabase.from(_table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw ScoutApiException(_mapPgCode(e));
    } on SocketException {
      throw ScoutApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw ScoutApiException('unknow_error');
    }
  }

  // birthday → 'YYYY-MM-DD' (Postgres `date` no acepta ISO timestamp).
  // removeWhere null para no enviar columnas vacías y no sobreescribir
  // valores existentes en update.
  Map<String, dynamic> _serialize(Scout s) {
    final json = s.toJson();
    final bd = s.birthday;
    json['birthday'] =
        '${bd.year.toString().padLeft(4, '0')}-'
        '${bd.month.toString().padLeft(2, '0')}-'
        '${bd.day.toString().padLeft(2, '0')}';
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
