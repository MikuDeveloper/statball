class ScoutMatchApiException implements Exception {
  ScoutMatchApiException(this.code, [message = '']);

  final String code;

  String get message => switch (code) {
    'not_found' => 'La asignación no fue encontrada',
    'permission_denied' => 'No tienes permisos para realizar esta acción',
    'database_error' => 'Error de conexión con la base de datos',
    'network_error' => 'Hubo un problema con la conexión a internet',
    'already_assigned' => 'Este scout ya está asignado a este partido',
    _ => 'Ocurrió un error inesperado (Código: $code)',
  };

  @override
  String toString() => message;
}
