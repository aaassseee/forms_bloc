import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/validation.dart';
import '../model/validator.dart';

part 'forms_field_state.dart';

abstract class FormsField<T> {
  abstract T initialValue;

  void setInitialValue(T value);

  void updateValue(T value);
}

abstract class FormsFieldCubit<T> extends Cubit<FormsFieldState>
    with FormsFieldCubitValidationMixin<T>
    implements FormsField<T> {
  FormsFieldCubit({
    required this.initialValue,
    this.validatorList = const [],
  }) : super(FormsFieldValueInitialized<T>(
          value: initialValue,
          valueStatus: FormsFieldValueStatus.initial,
          validationStatus: FormsFieldValidationStatus.initial,
        ));

  @override
  T initialValue;

  @override
  List<FieldValidator<T>> validatorList;

  @override
  void setInitialValue(value) {
    final state = this.state;
    if (state is FormsFieldValuedState<T> &&
        state.validationStatus == FormsFieldValidationStatus.validating) {
      return;
    }

    emit(FormsFieldValueChanged<T>(
        value: value,
        valueStatus: FormsFieldValueStatus.initial,
        validationStatus: FormsFieldValidationStatus.initial));
  }

  @override
  void updateValue(T value) {
    final state = this.state;
    if (state is FormsFieldValuedState<T> &&
        state.validationStatus == FormsFieldValidationStatus.validating) {
      return;
    }

    emit(FormsFieldValueChanged<T>(
        value: value,
        valueStatus: FormsFieldValueStatus.initial,
        validationStatus: FormsFieldValidationStatus.initial));
  }
}

abstract class FormsMultipleSelectionFieldCubit<T> extends FormsFieldCubit<T> {
  FormsMultipleSelectionFieldCubit({
    required super.initialValue,
    super.validatorList = const [],
    this.itemList = const [],
  });

  final List<T> itemList;
}
