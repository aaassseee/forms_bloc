import 'dart:async';

import 'package:forms_cubit/field/model/field_exception.dart';

enum FieldValidatorTriggerType {
  initial,
  valueChanged,
  unfocus,
}

abstract class FormsValidator {
  const FormsValidator();
}

abstract class FormsFieldValidator<T> extends FormsValidator {
  const FormsFieldValidator({required this.triggerTypeList});

  final Iterable<FieldValidatorTriggerType> triggerTypeList;

  FutureOr validate(T value);
}

class FormsFieldRequiredValidator<T> extends FormsFieldValidator<T> {
  const FormsFieldRequiredValidator({required super.triggerTypeList});

  @override
  FutureOr validate(T value) {
    if (value == null ||
        value == false ||
        value is Iterable && value.isEmpty ||
        value is String && value.isEmpty ||
        value is Map && value.isEmpty) {
      throw FormsFieldRequiredException();
    }
  }
}
