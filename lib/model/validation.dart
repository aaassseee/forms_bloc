import 'package:bloc/bloc.dart';

import '../base/forms_field_cubit.dart';
import 'validator.dart';

abstract class FormsValidation {
  void validate();

  abstract bool isValidate;
}

abstract class FormsFieldValidation<T> extends FormsValidation {
  abstract covariant List<FieldValidator<T>> validatorList;

  void addValidator(FieldValidator<T> validator);

  void addValidatorList(Iterable<FieldValidator<T>> validatorList);

  void insertValidator(int index, FieldValidator<T> validator);

  void insertValidatorList(
      int index, Iterable<FieldValidator<T>> validatorList);

  void updateValidator(Iterable<FieldValidator<T>> validatorList);

  void removeValidator(FieldValidator<T> validator);
}

mixin FormsFieldCubitValidationMixin<T> on Cubit<FormsFieldState>
    implements FormsFieldValidation<T> {
  @override
  bool isValidate = true;

  @override
  void validate() {
    final state = this.state;
    if (state is! FormsFieldValuedState<T>) {
      throw (Exception('Form is initializing'));
    }

    if (state.validationStatus == FormsFieldValidationStatus.validating) {
      return;
    }

    try {
      for (final validator in validatorList) {
        validator.validate(state.value);
      }
    } catch (e) {
      emit(state.copyWith(validationStatus: FormsFieldValidationStatus.failed));
    }

    emit(state.copyWith(validationStatus: FormsFieldValidationStatus.pass));
  }

  @override
  void addValidator(FieldValidator<T> validator) {
    validatorList.add(validator);
  }

  @override
  void addValidatorList(Iterable<FieldValidator<T>> validatorList) {
    this.validatorList.addAll(validatorList);
  }

  @override
  void insertValidator(int index, FieldValidator<T> validator) {
    validatorList.insert(index, validator);
  }

  @override
  void insertValidatorList(
      int index, Iterable<FieldValidator<T>> validatorList) {
    this.validatorList.insertAll(index, validatorList);
  }

  @override
  void updateValidator(Iterable<FieldValidator<T>> validatorList) {
    this.validatorList = List.from(validatorList);
  }

  @override
  void removeValidator(FieldValidator<T> validator) {
    validatorList.remove(validator);
  }
}

abstract class FormsFormValidation extends FormsValidation {}
