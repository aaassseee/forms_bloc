import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_cubit/model/validation.dart';

part 'forms_field_state.dart';

abstract class FormsFieldCubitBase<T> extends Cubit<FormsFieldState<T>> {
  FormsFieldCubitBase({
    required T initialValue,
    FormsFieldValidation<T>? validation,
  })  : _validation = validation ?? FormsFieldValidation(),
        super(FormsFieldState<T>(
          initialValue: initialValue,
          value: initialValue,
          valueStatus: FormsFieldValueStatus.initial,
          validationStatus: FormsFieldValidationStatus.initial,
        ));

  T get initialValue => state.initialValue;

  T get value => state.value;

  final FormsFieldValidation<T> _validation;

  /// Easy getter function for checking current state is validating
  bool get isValidating =>
      state.validationStatus == FormsFieldValidationStatus.validating;

  bool get isInitial => state.valueStatus == FormsFieldValueStatus.initial;

  bool isInitialValue(T value) => initialValue == value;

  bool isValue(T value) => this.value == value;

  void updateInitialValue(T initialValue) {
    if (isValidating || isInitialValue(initialValue)) {
      return;
    }

    final valueStatus = isValue(initialValue)
        ? FormsFieldValueStatus.initial
        : FormsFieldValueStatus.changed;
    emit(state.copyWith(initialValue: initialValue, valueStatus: valueStatus));
  }

  void updateValue(T value) {
    if (isValidating || isValue(value)) {
      return;
    }

    final valueStatus = isInitialValue(value)
        ? FormsFieldValueStatus.initial
        : FormsFieldValueStatus.changed;
    emit(state.copyWith(value: value, valueStatus: valueStatus));
  }

  FutureOr<bool> validate() async {
    if (isValidating) {
      throw Error();
    }

    emit(state.copyWith(
        validationStatus: FormsFieldValidationStatus.validating));
    await _validation.validate(value);

    final isValid = _validation.isValidate;
    emit(state.copyWith(
        validationStatus: isValid
            ? FormsFieldValidationStatus.pass
            : FormsFieldValidationStatus.failed));
    return isValid;
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

class TextFormsFieldCubit extends SingleValueFormsFieldCubit<String> {
  TextFormsFieldCubit({
    required super.initialValue,
    super.validation,
  });
}
