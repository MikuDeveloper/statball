import 'package:reactive_forms/reactive_forms.dart';

class FormGroupState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final FormGroup formGroup;

  FormGroupState({
    required this.isLoading,
    this.isSuccess = false,
    this.errorMessage,
    required this.formGroup,
  });

  FormGroupState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
    FormGroup? formGroup,
  }) {
    return FormGroupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      formGroup: formGroup ?? this.formGroup,
    );
  }

  @override
  bool operator ==(covariant FormGroupState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.errorMessage == errorMessage &&
        other.formGroup == formGroup;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        errorMessage.hashCode ^
        formGroup.hashCode;
  }

  @override
  String toString() {
    return 'FormGroupState(isLoading: $isLoading, isSuccess: $isSuccess, errorMessage: $errorMessage, formGroup: $formGroup)';
  }
}
