import 'dart:async';

import 'package:forms_cubit/forms_cubit.dart';

import 'error.dart';

class MockFormsFieldValidator<T> extends FormsFieldValidator<T> {
  const MockFormsFieldValidator({required super.triggerTypeList});

  @override
  FutureOr validate(T value) {}
}

class MockFailureFormsFieldValidator<T> extends MockFormsFieldValidator<T> {
  const MockFailureFormsFieldValidator({required super.triggerTypeList});

  @override
  FutureOr validate(T value) {
    super.validate(value);
    throw MockFormsFieldValidationException();
  }
}

class MockAsyncFormsFieldValidator<T> extends FormsFieldValidator<T> {
  const MockAsyncFormsFieldValidator({required super.triggerTypeList});

  @override
  FutureOr validate(T value) async {
    await Future.delayed(Duration(seconds: 1));
  }
}

class MockFailureAsyncFormsFieldValidator<T>
    extends MockAsyncFormsFieldValidator<T> {
  const MockFailureAsyncFormsFieldValidator({required super.triggerTypeList});

  @override
  FutureOr validate(T value) async {
    await super.validate(value);
    throw MockFormsFieldValidationException();
  }
}
