import 'dart:io';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/domain/index.dart' show SbUserRepository, SbUser;
import 'package:statball/infrastructure/index.dart' show SbUserApiException;

class SbUserApi implements SbUserRepository {
  final _log = Logger('SbUserApi');
  final _supabase = Supabase.instance.client;

  @override
  Future<SbUser> getUserData() async {
    try {
      if (!isLoggedIn()) {
        throw SbUserApiException('is_not_logged');
      }

      final user = _supabase.auth.currentUser!;
      final userData = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      return SbUser.fromJson(userData);
    } on SbUserApiException catch (e) {
      throw SbUserApiException(e.code);
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SbUserApiException('database_error');
    } on SocketException {
      throw SbUserApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SbUserApiException('unknow_error');
    }
  }

  @override
  bool isLoggedIn() {
    return _supabase.auth.currentUser != null &&
        _supabase.auth.currentSession != null &&
        !_supabase.auth.currentSession!.isExpired;
  }

  @override
  Future<SbUser> login({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.auth.signInWithPassword(email: email, password: password);

      final user = _supabase.auth.currentUser!;
      final userData = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      return SbUser.fromJson(userData);
    } on AuthException catch (e) {
      _log.severe(e.toString());
      throw SbUserApiException(e.code ?? 'auth_error');
    } on PostgrestException catch (e) {
      _log.severe(e.toString());
      throw SbUserApiException('database_error');
    } on SocketException {
      throw SbUserApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SbUserApiException('unknow_error');
    }
  }

  @override
  Future<void> logout() async => await _supabase.auth.signOut();

  @override
  Future<void> sendResetPassEmail({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      _log.severe(e.toString());
      throw SbUserApiException(e.code ?? 'auth_error');
    } on SocketException {
      throw SbUserApiException('network_error');
    } catch (e) {
      _log.severe(e.toString());
      throw SbUserApiException('unknow_error');
    }
  }
}
