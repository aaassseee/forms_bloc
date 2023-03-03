part of 'forms_field_cubit.dart';

enum FormsFieldValueStatus {
  initial,
  changed,
}

class FormsFieldValueState<T> extends Equatable {
  const FormsFieldValueState({
    required this.initialValue,
    required this.value,
  });

  final T initialValue;

  final T value;

  FormsFieldValueStatus get status => isInitialValue(value)
      ? FormsFieldValueStatus.initial
      : FormsFieldValueStatus.changed;

  bool get isInitial => status == FormsFieldValueStatus.initial;

  bool isInitialValue(T value) => initialValue == value;

  @override
  List<Object?> get props => [
        initialValue,
        value,
      ];

  FormsFieldValueState<T> copyWith({
    T? initialValue,
    T? value,
  }) =>
      FormsFieldValueState(
        initialValue: initialValue ?? this.initialValue,
        value: value ?? this.value,
      );
}

enum FormsFieldValidationStatus {
  initial,
  validating,
  validated,
}

class FormsFieldValidationState extends Equatable {
  const FormsFieldValidationState({
    this.error,
    required this.status,
  });

  final dynamic error;

  final FormsFieldValidationStatus status;

  bool get isValid => error == null;

  @override
  List<Object?> get props => [
        error,
        status,
      ];

  FormsFieldValidationState copyWith({
    dynamic error,
    FormsFieldValidationStatus? status,
  }) =>
      FormsFieldValidationState(
        error: error ?? this.error,
        status: status ?? this.status,
      );
}

class FormsFieldState<T> extends Equatable {
  const FormsFieldState({
    required this.valueState,
    required this.validationState,
  });

  final FormsFieldValueState<T> valueState;

  final FormsFieldValidationState validationState;

  @override
  List<Object?> get props => [
        valueState,
        validationState,
      ];

  FormsFieldState<T> copyWith({
    FormsFieldValueState<T>? valueState,
    FormsFieldValidationState? validationState,
  }) =>
      FormsFieldState<T>(
        valueState: valueState ?? this.valueState,
        validationState: validationState ?? this.validationState,
      );
}
