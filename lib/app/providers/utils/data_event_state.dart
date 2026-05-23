sealed class DataEventState {}

class InitialEvent extends DataEventState {}

class LoadingEvent extends DataEventState {}

class SuccessEvent<T> extends DataEventState {
  final T data;
  SuccessEvent(this.data);
}

class ErrorEvent extends DataEventState {
  final String message;
  ErrorEvent(this.message);
}
