class MatchesPlayerApiException implements Exception {
  MatchesPlayerApiException(this.code);

  final String code;

  String get message => switch (code) {
    'not_found' => 'El jugador del partido no fue encontrado',
    'permission_denied' => 'No tienes permisos para realizar esta acción',
    'database_error' => 'Error de conexión con la base de datos',
    'network_error' => 'Hubo un problema con la conexión a internet',
    'already_exists' => 'Este jugador ya está registrado en el partido',
    _ => 'Ocurrió un error inesperado (Código: $code)',
  };

  @override
  String toString() => message;
}
