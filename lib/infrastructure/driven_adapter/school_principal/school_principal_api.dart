import 'dart:io';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/domain/index.dart'
    show SchoolPrincipalRepository, SchoolPrincipal;
import 'package:statball/infrastructure/index.dart'
    show SchoolPrincipalApiException;

class SchoolPrincipalApi implements SchoolPrincipalRepository {
  final _log = Logger('SchoolPrincipalApi');
  final _supabase = Supabase.instance.client;

  static const _table = 'school_principals';

  @override
  Future<List<SchoolPrincipal>> getAll() async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .order('lastname', ascending: true)
          .order('name', ascending: true);
      return (data as List)
          .map((e) => SchoolPrincipal.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SchoolPrincipalApiException(_mapPgCode(e));
    } on SocketException {
      throw SchoolPrincipalApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SchoolPrincipalApiException('unknow_error');
    }
  }

  @override
  Future<SchoolPrincipal> getById(int id) async {
    try {
      final data = await _supabase
          .from(_table)
          .select()
          .eq('id', id)
          .maybeSingle();
      if (data == null) throw SchoolPrincipalApiException('not_found');
      return SchoolPrincipal.fromJson(data);
    } on SchoolPrincipalApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SchoolPrincipalApiException(_mapPgCode(e));
    } on SocketException {
      throw SchoolPrincipalApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SchoolPrincipalApiException('unknow_error');
    }
  }

  @override
  Future<SchoolPrincipal> create(SchoolPrincipal principal) async {
    try {
      final payload = principal.toJson()..remove('id');
      final data = await _supabase
          .from(_table)
          .insert(payload)
          .select()
          .single();
      return SchoolPrincipal.fromJson(data);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SchoolPrincipalApiException(_mapPgCode(e));
    } on SocketException {
      throw SchoolPrincipalApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SchoolPrincipalApiException('unknow_error');
    }
  }

  @override
  Future<SchoolPrincipal> update(SchoolPrincipal principal) async {
    try {
      if (principal.id == null) {
        throw SchoolPrincipalApiException('not_found');
      }
      final payload = principal.toJson()..remove('id');
      final data = await _supabase
          .from(_table)
          .update(payload)
          .eq('id', principal.id!)
          .select()
          .single();
      return SchoolPrincipal.fromJson(data);
    } on SchoolPrincipalApiException {
      rethrow;
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SchoolPrincipalApiException(_mapPgCode(e));
    } on SocketException {
      throw SchoolPrincipalApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SchoolPrincipalApiException('unknow_error');
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _supabase.from(_table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SchoolPrincipalApiException(_mapPgCode(e));
    } on SocketException {
      throw SchoolPrincipalApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SchoolPrincipalApiException('unknow_error');
    }
  }

  // Mapea códigos Postgres a códigos internos.
  // 23503 = foreign_key_violation → escuelas referenciando este principal.
  String _mapPgCode(PostgrestException e) {
    return switch (e.code) {
      '23503' => 'has_associations',
      '42501' => 'permission_denied',
      _ => 'database_error',
    };
  }
}
