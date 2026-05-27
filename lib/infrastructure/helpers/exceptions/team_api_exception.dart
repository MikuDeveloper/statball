class TeamApiException implements Exception {
  TeamApiException(this.code, [message = '']);

  final String code;

  String get message => switch (code) {
    'not_found' => 'El equipo no fue encontrado',
    'permission_denied' => 'No tienes permisos para realizar esta acción',
    'database_error' => 'Error de conexión con la base de datos',
    'network_error' => 'Hubo un problema con la conexión a internet',
    'has_associations' =>
      'No se puede eliminar: hay jugadores o partidos asociados al equipo',
    'school_required' => 'Debes seleccionar una escuela para el equipo',
    _ => 'Ocurrió un error inesperado (Código: $code)',
  };

  @override
  String toString() => message;
}
