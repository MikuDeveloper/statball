class SbUserApiException implements Exception {
  SbUserApiException(this.code, [message = '']);

  final String code;

  String get message => switch (code) {
    'invalid_credentials' => 'Correo o contraseña incorrectos',
    'auth_error' => 'Error interno en el servicio de autenticación',
    'network_error' => 'Hubo un problema con la conexión a internet',
    'user_not_found' => 'El usuario no fue encontrado en el sistema',
    'wrong_password' => 'La contraseña ingresada es incorrecta',
    'email_in_use' => 'Este correo electrónico ya está registrado',
    'database_error' => 'Error de conexión con la base de datos',
    // TODO: Changing message
    'email_address_invalid' => 'email_address_invalid',
    'over_email_send_rate_limit' => 'over_email_send_rate_limit',
    _ => 'Ocurrió un error inesperado (Código: $code)',
  };

  @override
  String toString() => message;
}
