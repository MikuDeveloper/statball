class SchoolPrincipalApiException implements Exception {
  SchoolPrincipalApiException(this.code, [message = '']);

  final String code;

  String get message => switch (code) {
    'not_found' => 'El director no fue encontrado',
    'permission_denied' => 'No tienes permisos para realizar esta acción',
    'database_error' => 'Error de conexión con la base de datos',
    'network_error' => 'Hubo un problema con la conexión a internet',
    'has_associations' =>
      'No se puede eliminar: hay escuelas asociadas a este director',
    _ => 'Ocurrió un error inesperado (Código: $code)',
  };

  @override
  String toString() => message;
}
