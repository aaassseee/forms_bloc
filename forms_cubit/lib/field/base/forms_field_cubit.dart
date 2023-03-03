import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../forms_cubit.dart';

part 'forms_field_state.dart';

abstract class FormsFieldCubitBase<T> extends Cubit<FormsFieldState<T>> {
  FormsFieldCubitBase({
    required T initialValue,
    FormsFieldValidation<T>? validation,
  })  : _validation = validation ?? FormsFieldValidation(),
        super(FormsFieldState<T>(
          valueState: FormsFieldValueState(
              initialValue: initialValue, value: initialValue),
          validationState: FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial),
        ));

  T get initialValue => state.valueState.initialValue;

  T get value => state.valueState.value;

  final FormsFieldValidation<T> _validation;

  bool get isInitial =>
      state.valueState.status == FormsFieldValueStatus.initial;

  /// Easy getter function for checking current state is validating
  bool get isValidating =>
      state.validationState.status == FormsFieldValidationStatus.validating;

  bool get isValid => state.validationState.isValid;

  bool isInitialValue(T value) => initialValue == value;

  bool isValue(T value) => this.value == value;

  void updateInitialValue(T initialValue) {
    if (isValidating || isInitialValue(initialValue)) {
      return;
    }

    emit(state.copyWith(
        valueState: state.valueState.copyWith(initialValue: initialValue)));
  }

  void updateValue(T value) {
    if (isValidating || isValue(value)) {
      return;
    }

    emit(state.copyWith(valueState: state.valueState.copyWith(value: value)));
  }

  FutureOr<bool> validate() async {
    if (isValidating) {
      throw FormsFieldValidatingException();
    }

    emit(state.copyWith(
        validationState: state.validationState
            .copyWith(status: FormsFieldValidationStatus.validating)));
    await _validation.validate(value);

    emit(state.copyWith(
        validationState: state.validationState.copyWith(
            error: _validation.error,
            status: FormsFieldValidationStatus.validated)));
    return _validation.isValidate;
  }
}

abstract class FormsFieldCubit<T> extends FormsFieldCubitBase<T> {
  FormsFieldCubit({
    required super.initialValue,
    super.validation,
  });
}

abstract class SelectionFormsFieldCubit<T> extends FormsFieldCubitBase<T> {
  SelectionFormsFieldCubit({
    required super.initialValue,
    super.validation,
    required this.itemList,
  });

  final List<T> itemList;

  void updateItemList(List<T> itemList) {
    if (isValidating) {
      return;
    }

    this.itemList
      ..clear()
      ..addAll(itemList);
  }
}

abstract class SingleSelectionFormsFieldCubit<T>
    extends SelectionFormsFieldCubit<T> {
  SingleSelectionFormsFieldCubit({
    required super.initialValue,
    required super.itemList,
  });

  void selectValue(T value) {
    if (this.value == value) return;

    updateValue(value);
  }
}

abstract class MultipleSelectionFormsFieldCubit<T>
    extends SelectionFormsFieldCubit<Iterable<T>> {
  MultipleSelectionFormsFieldCubit({
    required super.initialValue,
    required super.itemList,
  });

  void selectValue(T value) {
    if (this.value.contains(value)) return;

    updateValue(this.value.toList()..add(value));
  }

  void selectValueList(Iterable<T> valueList) {
    final resultList = this.value.toList();
    for (final value in valueList) {
      if (resultList.contains(value)) continue;

      resultList.add(value);
    }

    updateValue(resultList);
  }

  void unselectValue(T value) {
    if (!this.value.contains(value)) return;

    updateValue(this.value.toList()..remove(value));
  }

  void unselectValueList(Iterable<T> valueList) {
    final resultList = this.value.toList();
    for (final value in valueList) {
      resultList.remove(value);
    }

    updateValue(resultList);
  }
}
