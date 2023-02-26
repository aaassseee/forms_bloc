import 'dart:async';

import 'field_error.dart';

abstract class Validator {
  const Validator();
}

enum FieldValidatorTriggerType {
  valueChanged,
  unfocus,
}

abstract class FieldValidator<T> extends Validator {
  const FieldValidator({required this.triggerTypeList});

  final Iterable<FieldValidatorTriggerType> triggerTypeList;

  FutureOr validate(T value);
}

class RequiredFieldValidator<T> extends FieldValidator<T> {
  RequiredFieldValidator({required super.triggerTypeList});

  @override
  FutureOr validate(T value) {
    if (value == null ||
        value == false ||
        value is Iterable && value.isEmpty ||
        value is String && value.isEmpty ||
        value is Map && value.isEmpty) {
      throw FormsFieldRequiredError();
    }
  }
}
