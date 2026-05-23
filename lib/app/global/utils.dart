import 'enums.dart';

class DataState<T> {
  final DataStatus status;
  final T? data;
  final String? errorMessage;

  const DataState({
    this.status = DataStatus.initial,
    this.data,
    this.errorMessage,
  });

  // copyWith nos permite emitir un nuevo estado cambiando solo lo que necesitamos
  DataState<T> copyWith({DataStatus? status, T? data, String? errorMessage}) {
    return DataState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage, // Puede ser null si no hay error
    );
  }
}
