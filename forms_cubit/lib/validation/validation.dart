import 'dart:async';

import 'validator.dart';

class FormsFieldValidation<T> {
  FormsFieldValidation({List<FormsFieldValidator<T>> validatorList = const []})
      : _validatorList = validatorList;

  final List<FormsFieldValidator<T>> _validatorList;

  List<FormsFieldValidator<T>> get validatorList => _validatorList;

  bool get isValidate => _error != null;

  dynamic _error;

  dynamic get error => _error;

  FutureOr validate(T value) async {
    try {
      for (final validator in _validatorList) {
        await validator.validate(value);
      }
      _error = null;
    } catch (error) {
      _error = error;
      return;
    }
  }

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

  void updateValidator(Iterable<FormsFieldValidator<T>> validatorList) {
    _validatorList
      ..clear()
      ..addAll(validatorList);
  }

  void removeValidator(FormsFieldValidator<T> validator) {
    _validatorList.remove(validator);
  }
}
