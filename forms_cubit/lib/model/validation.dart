import 'dart:async';

import 'validator.dart';

class FormsFieldValidation<T> {
  FormsFieldValidation({List<FieldValidator<T>> validatorList = const []})
      : _validatorList = validatorList;

  List<FieldValidator<T>> _validatorList;

  List<FieldValidator<T>> get validatorList => _validatorList;

  bool _isValidate = false;

  bool get isValidate => _isValidate;

  FutureOr validate(T value) async {
    try {
      for (final validator in _validatorList) {
        await validator.validate(value);
      }
    } catch (error) {
      _isValidate = false;
      return;
    }

    _isValidate = true;
  }

  void addValidator(FieldValidator<T> validator) {
    _validatorList.add(validator);
  }

  void addValidatorList(Iterable<FieldValidator<T>> validatorList) {
    _validatorList.addAll(validatorList);
  }

  void insertValidator(int index, FieldValidator<T> validator) {
    _validatorList.insert(index, validator);
  }

  void insertValidatorList(
      int index, Iterable<FieldValidator<T>> validatorList) {
    _validatorList.insertAll(index, validatorList);
  }

  void updateValidator(Iterable<FieldValidator<T>> validatorList) {
    _validatorList = List.from(validatorList);
  }

  void removeValidator(FieldValidator<T> validator) {
    _validatorList.remove(validator);
  }
}
