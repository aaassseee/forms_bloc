part of 'forms_field_cubit.dart';

abstract class FormsFieldState extends Equatable {
  const FormsFieldState();
}

class FormsFieldInitial extends FormsFieldState {
  const FormsFieldInitial();

  @override
  List<Object?> get props => [];
}

enum FormsFieldValidationStatus {
  initial,
  validating,
  pass,
  failed,
}

enum FormsFieldValueStatus {
  initial,
  changed,
}

abstract class FormsFieldValuedState<T> extends FormsFieldState {
  const FormsFieldValuedState({
    required this.value,
    required this.valueStatus,
    required this.validationStatus,
  });

  final T value;

  final FormsFieldValueStatus valueStatus;

  final FormsFieldValidationStatus validationStatus;

  @override
  List<Object?> get props => [
        value,
        valueStatus,
        validationStatus,
      ];

  FormsFieldValuedState<T> copyWith({
    T? value,
    FormsFieldValueStatus? valueStatus,
    FormsFieldValidationStatus? validationStatus,
  });
}

class FormsFieldValueInitialized<T> extends FormsFieldValuedState<T> {
  const FormsFieldValueInitialized({
    required super.value,
    required super.valueStatus,
    required super.validationStatus,
  });

  @override
  FormsFieldValueInitialized<T> copyWith({
    T? value,
    FormsFieldValueStatus? valueStatus,
    FormsFieldValidationStatus? validationStatus,
  }) =>
      FormsFieldValueInitialized(
        value: value ?? this.value,
        valueStatus: valueStatus ?? this.valueStatus,
        validationStatus: validationStatus ?? this.validationStatus,
      );
}

class FormsFieldValueChanged<T> extends FormsFieldValuedState<T> {
  const FormsFieldValueChanged({
    required super.value,
    required super.valueStatus,
    required super.validationStatus,
  });

  @override
  FormsFieldValuedState<T> copyWith({
    T? value,
    FormsFieldValueStatus? valueStatus,
    FormsFieldValidationStatus? validationStatus,
  }) =>
      FormsFieldValueChanged(
        value: value ?? this.value,
        valueStatus: valueStatus ?? this.valueStatus,
        validationStatus: validationStatus ?? this.validationStatus,
      );
}
