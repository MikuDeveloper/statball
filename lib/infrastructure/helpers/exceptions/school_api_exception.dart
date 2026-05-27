class SchoolApiException implements Exception {
  SchoolApiException(this.code, [message = '']);

  final String code;

  String get message => switch (code) {
    'not_found' => 'La escuela no fue encontrada',
    'permission_denied' => 'No tienes permisos para realizar esta acción',
    'database_error' => 'Error de conexión con la base de datos',
    'network_error' => 'Hubo un problema con la conexión a internet',
    'duplicate_name' => 'Ya existe una escuela con ese nombre',
    _ => 'Ocurrió un error inesperado (Código: $code)',
  };

  @override
  String toString() => message;
}
