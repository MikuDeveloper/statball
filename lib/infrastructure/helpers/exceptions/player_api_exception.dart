class PlayerApiException implements Exception {
  PlayerApiException(this.code, [message = '']);

  final String code;

  String get message => switch (code) {
    'not_found' => 'El jugador no fue encontrado',
    'permission_denied' => 'No tienes permisos para realizar esta acción',
    'database_error' => 'Error de conexión con la base de datos',
    'network_error' => 'Hubo un problema con la conexión a internet',
    'has_associations' =>
      'No se puede eliminar: hay partidos o eventos asociados al jugador',
    _ => 'Ocurrió un error inesperado (Código: $code)',
  };

  @override
  String toString() => message;
}
