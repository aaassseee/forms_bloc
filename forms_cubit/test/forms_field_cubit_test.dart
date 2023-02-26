import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms_cubit/base/forms_field_cubit.dart';
import 'package:forms_cubit/model/validation.dart';
import 'package:forms_cubit/model/validator.dart';

void main() {
  group('forms field value', () {
    blocTest<TextFormsFieldCubit, FormsFieldState<String>>(
      'forms field validation pass with no validation',
      build: () => TextFormsFieldCubit(initialValue: ''),
      act: (bloc) => bloc.validate(),
      expect: () => const [
        FormsFieldState<String>(
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.validating),
        FormsFieldState<String>(
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.pass),
      ],
    );
  });

  group('forms field validation', () {
    blocTest<TextFormsFieldCubit, FormsFieldState<String>>(
      'forms field validation pass with no validation',
      build: () => TextFormsFieldCubit(initialValue: ''),
      act: (bloc) => bloc.validate(),
      expect: () => const [
        FormsFieldState<String>(
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.validating),
        FormsFieldState<String>(
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.pass),
      ],
    );

    blocTest<TextFormsFieldCubit, FormsFieldState<String>>(
      'forms field validation pass with required validation',
      build: () => TextFormsFieldCubit(
          initialValue: '',
          validation: FormsFieldValidation(validatorList: [
            RequiredFieldValidator(
                triggerTypeList: FieldValidatorTriggerType.values)
          ])),
      act: (bloc) => bloc.validate(),
      expect: () => const [
        FormsFieldState<String>(
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.validating),
        FormsFieldState<String>(
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.failed),
      ],
    );
  });
}
