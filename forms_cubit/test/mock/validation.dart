import 'package:forms_cubit/forms_cubit.dart';

import 'validator.dart';

class MockFormsFieldValidation<T> extends FormsFieldValidation<T> {
  MockFormsFieldValidation({List<FormsFieldValidator<T>>? validatorList})
      : super(
          validatorList: validatorList ??
              [
                MockFormsFieldValidator<T>(
                    triggerTypeList: FieldValidatorTriggerType.values),
              ],
        );
}

class MockAsyncFormsFieldValidation<T> extends FormsFieldValidation<T> {
  MockAsyncFormsFieldValidation({List<FormsFieldValidator<T>>? validatorList})
      : super(
          validatorList: validatorList ??
              [
                MockAsyncFormsFieldValidator<T>(
                    triggerTypeList: FieldValidatorTriggerType.values),
              ],
        );
}

class MockFailureFormsFieldValidation<T> extends FormsFieldValidation<T> {
  MockFailureFormsFieldValidation({List<FormsFieldValidator<T>>? validatorList})
      : super(
          validatorList: validatorList ??
              [
                MockFailureFormsFieldValidator<T>(
                    triggerTypeList: FieldValidatorTriggerType.values),
              ],
        );
}

class MockFailureAsyncFormsFieldValidation<T> extends FormsFieldValidation<T> {
  MockFailureAsyncFormsFieldValidation(
      {List<FormsFieldValidator<T>>? validatorList})
      : super(
          validatorList: validatorList ??
              [
                MockFailureAsyncFormsFieldValidator<T>(
                    triggerTypeList: FieldValidatorTriggerType.values),
              ],
        );
}
