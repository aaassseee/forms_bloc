import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../forms_bloc.dart';

part 'forms_field_state.dart';

abstract class FormsFieldCubitBase<T, State extends FormsFieldState<T>>
    extends Cubit<State> {
  FormsFieldCubitBase(
    super.initialState, {
    required T initialValue,
    FormsFieldValidation<T>? validation,
  }) : _validation = validation ?? FormsFieldValidation() {
    _validation.validate(initialValue,
        triggerType: FormsFieldValidatorTriggerType.initial);
  }

  T get initialValue => state.valueState.initialValue;

  T get value => state.valueState.value;

  final FormsFieldValidation<T> _validation;

  bool get isInitial => state.valueState.isInitial;

  bool get isValidating => state.validationState.isValidating;

  bool get isValid => state.validationState.isValid;

  bool isInitialValue(T value) => state.valueState.isInitialValue(value);

  bool isValue(T value) => this.value == value;

  void updateInitialValue(T initialValue) {
    if (isValidating || isInitialValue(initialValue)) {
      return;
    }

    emit(state.copyWith(
            valueState: state.valueState.copyWith(initialValue: initialValue))
        as State);
  }

  FutureOr validate({FormsFieldValidatorTriggerType? triggerType}) async {
    // if trigger type not in any validator
    if (triggerType != null &&
        !_validation.validatorList.any(
            (validator) => validator.triggerTypeList.contains(triggerType))) {
      return;
    }

    emit(state.copyWith(
        validationState: state.validationState
            .copyWith(status: FormsFieldValidationStatus.validating)) as State);
    await _validation.validate(value, triggerType: triggerType);

    emit(state.copyWith(
        validationState: state.validationState.copyWith(
            error: _validation.errorList,
            status: FormsFieldValidationStatus.validated)) as State);
  }
}

abstract class FormsFieldCubit<T>
    extends FormsFieldCubitBase<T, FormsFieldState<T>> {
  FormsFieldCubit({
    required super.initialValue,
    super.validation,
  }) : super(FormsFieldState<T>(
          valueState: FormsFieldValueState(
              initialValue: initialValue, value: initialValue),
          validationState: const FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial),
        ));

  void updateValue(T value) {
    if (isValue(value)) {
      return;
    }

    emit(state.copyWith(valueState: state.valueState.copyWith(value: value)));
    validate(triggerType: FormsFieldValidatorTriggerType.valueChanged);
  }
}

abstract class FormsSelectionFieldCubit<T>
    extends FormsFieldCubitBase<T, FormsSelectionFieldState<T>> {
  FormsSelectionFieldCubit({
    required super.initialValue,
    required List<T> itemList,
    super.validation,
  }) : super(FormsSelectionFieldState<T>(
          itemState: FormsFieldItemState(itemList: itemList),
          valueState: FormsFieldValueState(
              initialValue: initialValue, value: initialValue),
          validationState: const FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial),
        ));

  Iterable<T> get itemList => state.itemState.itemList;

  bool containItem(T item) => itemList.contains(item);

  void updateItemList(List<T> itemList) {
    if (isValidating) {
      return;
    }

    emit(state.copyWith(
        itemState: state.itemState.copyWith(
            itemList: state.itemState.itemList.toList()
              ..clear()
              ..addAll(itemList))));
  }

  void addItem(T item) {
    if (containItem(item)) return;

    emit(state.copyWith(
        itemState: state.itemState
            .copyWith(itemList: state.itemState.itemList.toList()..add(item))));
  }

  void removeItem(T item) {
    if (!containItem(item)) return;

    emit(state.copyWith(
        itemState: state.itemState.copyWith(
            itemList: state.itemState.itemList.toList()..remove(item))));
  }
}

abstract class FormsSingleSelectionFieldCubit<T>
    extends FormsSelectionFieldCubit<T> {
  FormsSingleSelectionFieldCubit({
    required super.initialValue,
    required super.itemList,
    super.validation,
  });

  void selectValue(T value) {
    if (isValue(value)) {
      return;
    }

    if (!containItem(value)) {
      throw const FormsSelectionFieldNotInItemListException();
    }

    emit(state.copyWith(valueState: state.valueState.copyWith(value: value)));
    validate(triggerType: FormsFieldValidatorTriggerType.valueChanged);
  }
}

abstract class FormsMultipleSelectionFieldCubit<T>
    extends FormsSelectionFieldCubit<Iterable<T>> {
  FormsMultipleSelectionFieldCubit({
    required super.initialValue,
    required super.itemList,
    super.validation,
  });

  void selectValue(T value) {
    if (this.value.contains(value)) return;

    emit(state.copyWith(
        valueState:
            state.valueState.copyWith(value: this.value.toList()..add(value))));
    validate(triggerType: FormsFieldValidatorTriggerType.valueChanged);
  }

  void selectValueList(Iterable<T> valueList) {
    final resultList = value.toList();
    for (final value in valueList) {
      if (resultList.contains(value)) continue;

      resultList.add(value);
    }

    emit(state.copyWith(
        valueState: state.valueState.copyWith(value: resultList)));
    validate(triggerType: FormsFieldValidatorTriggerType.valueChanged);
  }

  void unselectValue(T value) {
    if (!this.value.contains(value)) return;

    emit(state.copyWith(
        valueState: state.valueState
            .copyWith(value: this.value.toList()..remove(value))));
    validate(triggerType: FormsFieldValidatorTriggerType.valueChanged);
  }

  void unselectValueList(Iterable<T> valueList) {
    final resultList = value.toList();
    for (final value in valueList) {
      resultList.remove(value);
    }

    emit(state.copyWith(
        valueState: state.valueState.copyWith(value: resultList)));
    validate(triggerType: FormsFieldValidatorTriggerType.valueChanged);
  }
}
