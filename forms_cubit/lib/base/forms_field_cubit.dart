import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_cubit/model/validation.dart';

part 'forms_field_state.dart';

abstract class FormsFieldCubitBase<T> extends Cubit<FormsFieldState<T>> {
  FormsFieldCubitBase({
    required T initialValue,
    FormsFieldValidation<T>? validation,
  })  : _initialValue = initialValue,
        _value = initialValue,
        _validation = validation ?? FormsFieldValidation(),
        super(FormsFieldState<T>(
          value: initialValue,
          valueStatus: FormsFieldValueStatus.initial,
          validationStatus: FormsFieldValidationStatus.initial,
        ));

  T _initialValue;

  T get initialValue => _initialValue;

  T _value;

  T get value => _value;

  final FormsFieldValidation<T> _validation;

  /// Easy getter function for checking current state is validating
  bool get isValidating =>
      state.validationStatus == FormsFieldValidationStatus.validating;

  bool checkIsInitialValue(T value) {
    return initialValue == value;
  }

  void updateInitialValue(T value) {
    if (isValidating) {
      return;
    }

    _initialValue = value;
  }

  void updateValue(T value) {
    if (isValidating) {
      return;
    }

    _value = value;
  }

  FutureOr<bool> validate() async {
    _validation.validate(_value);
    return _validation.isValidate;
  }
}

abstract class SingleValueFormsFieldCubit<T> extends FormsFieldCubitBase<T> {
  SingleValueFormsFieldCubit({
    required super.initialValue,
    super.validation,
  });
}

abstract class MultipleValueFormsFieldCubit<T>
    extends FormsFieldCubitBase<List<T>> {
  MultipleValueFormsFieldCubit({
    required super.initialValue,
    super.validation,
    required this.itemList,
  });

  final List<T> itemList;

  void selectValue(T value) => selectValueList([value]);

  void selectValueList(List<T> valueList) {
    if (isValidating) {
      return;
    }

    updateValue(value.toList()..addAll(valueList));
  }

  void unselectValue(T value) {
    unselectValueList([value]);
  }

  void unselectValueList(List<T> valueList) {
    if (isValidating) {
      return;
    }

    updateValue(
        value.toList()..removeWhere((element) => valueList.contains(element)));
  }

  void updateItemList(List<T> itemList) {
    if (isValidating) {
      return;
    }

    this.itemList
      ..clear()
      ..addAll(itemList);
  }
}
