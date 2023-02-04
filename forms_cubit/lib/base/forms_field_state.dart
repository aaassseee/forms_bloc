part of 'forms_field_cubit.dart';

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

class FormsFieldState<T> extends Equatable {
  const FormsFieldState({
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

  FormsFieldState<T> copyWith({
    T? value,
    FormsFieldValueStatus? valueStatus,
    FormsFieldValidationStatus? validationStatus,
  }) =>
      FormsFieldState<T>(
        value: value ?? this.value,
        valueStatus: valueStatus ?? this.valueStatus,
        validationStatus: validationStatus ?? this.validationStatus,
      );
}
