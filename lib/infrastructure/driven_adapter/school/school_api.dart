import 'dart:io';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/domain/index.dart' show SchoolRepository, School;
import 'package:statball/infrastructure/index.dart' show SchoolApiException;

class SchoolApi implements SchoolRepository {
  final _log = Logger('SchoolApi');
  final _supabase = Supabase.instance.client;

  static const _table = 'schools';

  @override
  Future<List<School>> getAll() async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .order('name', ascending: true);
      return (data as List)
          .map((e) => School.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SchoolApiException(_mapPgCode(e));
    } on SocketException {
      throw SchoolApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SchoolApiException('unknow_error');
    }
  }

  @override
  Future<School> getById(int id) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('id', id)
          .maybeSingle();
      if (data == null) throw SchoolApiException('not_found');
      return School.fromJson(data);
    } on SchoolApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SchoolApiException(_mapPgCode(e));
    } on SocketException {
      throw SchoolApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SchoolApiException('unknow_error');
    }
  }

  @override
  Future<School> create(School school) async {
    try {
      final payload = school.toJson()..remove('id');
      final data = await _supabase
          .from(_table)
          .insert(payload)
          .select()
          .single();
      return School.fromJson(data);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SchoolApiException(_mapPgCode(e));
    } on SocketException {
      throw SchoolApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SchoolApiException('unknow_error');
    }
  }

  @override
  Future<School> update(School school) async {
    try {
      if (school.id == null) throw SchoolApiException('not_found');
      final payload = school.toJson()..remove('id');
      final data = await _supabase
          .from(_table)
          .update(payload)
          .eq('id', school.id!)
          .select()
          .single();
      return School.fromJson(data);
    } on SchoolApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SchoolApiException(_mapPgCode(e));
    } on SocketException {
      throw SchoolApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SchoolApiException('unknow_error');
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _supabase.from(_table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SchoolApiException(_mapPgCode(e));
    } on SocketException {
      throw SchoolApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SchoolApiException('unknow_error');
    }
  }

  // Mapea códigos de Postgres a los códigos internos de la app
  String _mapPgCode(PostgrestException e) {
    // 23505 = unique_violation, 42501 = insufficient_privilege (RLS)
    return switch (e.code) {
      '23505' => 'duplicate_name',
      '42501' => 'permission_denied',
      _ => 'database_error',
    };
  }
}
