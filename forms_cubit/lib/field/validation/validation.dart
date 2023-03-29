import 'dart:async';

import '../model/field_exception.dart';

part 'validator.dart';

class FormsFieldValidation<T> {
  FormsFieldValidation({List<FormsFieldValidator<T>> validatorList = const []})
      : _validatorList = validatorList;

  final List<FormsFieldValidator<T>> _validatorList;

  List<FormsFieldValidator<T>> get validatorList => _validatorList;

  bool get isValid => validatorList.every(
      (validator) => validator.hasValidate && validator.exception == null);

  Iterable<FormsFieldException> get errorList =>
      validatorList.fold<List<FormsFieldException>>([], (list, validator) {
        final exception = validator.exception;
        if (exception == null) return list;
        return list..add(exception);
      });

  void addValidator(FormsFieldValidator<T> validator) {
    _validatorList.add(validator);
  }

  void addValidatorList(Iterable<FormsFieldValidator<T>> validatorList) {
    _validatorList.addAll(validatorList);
  }

  void insertValidator(int index, FormsFieldValidator<T> validator) {
    _validatorList.insert(index, validator);
  }

  void insertValidatorList(
      int index, Iterable<FormsFieldValidator<T>> validatorList) {
    _validatorList.insertAll(index, validatorList);
  }

  void updateValidatorList(Iterable<FormsFieldValidator<T>> validatorList) {
    _validatorList
      ..clear()
      ..addAll(validatorList);
  }

  void removeValidator(FormsFieldValidator<T> validator) {
    _validatorList.remove(validator);
  }

  FutureOr<void> validate(T value,
      {FormsFieldValidatorTriggerType? triggerType}) async {
    for (final validator in _validatorList) {
      if (triggerType != null &&
          !validator.triggerTypeList.contains(triggerType)) continue;
      await validator.validate(value);
    }
  }

  void reset() {
    _validatorList.forEach((validator) => validator.reset());
  }
}
