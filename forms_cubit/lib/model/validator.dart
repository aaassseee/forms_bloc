abstract class Validator {
  const Validator();
}

abstract class FieldValidator<T> extends Validator {
  const FieldValidator({required this.triggerTypeList});

  final Iterable<FieldValidatorTriggerType> triggerTypeList;

  void validate(T value);
}

enum FieldValidatorTriggerType {
  valueChanged,
  unfocus,
}
