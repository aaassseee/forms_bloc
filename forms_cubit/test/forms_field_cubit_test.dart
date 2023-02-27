import 'package:bloc_test/bloc_test.dart';
import 'package:forms_cubit/base/forms_field_cubit.dart';
import 'package:forms_cubit/model/validation.dart';
import 'package:forms_cubit/model/validator.dart';
import 'package:test/test.dart';

void main() {
  group(
    'forms field value',
    () {
      blocTest<TextFormsFieldCubit, FormsFieldState<String>>(
        'forms field value from initial to changed by update value',
        build: () => TextFormsFieldCubit(initialValue: ''),
        act: (bloc) => bloc.updateValue('test'),
        expect: () => const [
          FormsFieldState<String>(
            initialValue: '',
            value: 'test',
            valueStatus: FormsFieldValueStatus.changed,
            validationStatus: FormsFieldValidationStatus.initial,
          ),
        ],
      );

      blocTest<TextFormsFieldCubit, FormsFieldState<String>>(
        'forms field value from initial to changed by update initial value',
        build: () => TextFormsFieldCubit(initialValue: ''),
        act: (bloc) => bloc.updateInitialValue('test'),
        expect: () => const [
          FormsFieldState<String>(
            initialValue: 'test',
            value: '',
            valueStatus: FormsFieldValueStatus.changed,
            validationStatus: FormsFieldValidationStatus.initial,
          ),
        ],
      );

      blocTest<TextFormsFieldCubit, FormsFieldState<String>>(
        'forms field value status from changed to initial by update value',
        build: () => TextFormsFieldCubit(initialValue: 'test'),
        seed: () => FormsFieldState<String>(
          initialValue: 'test',
          value: '',
          valueStatus: FormsFieldValueStatus.changed,
          validationStatus: FormsFieldValidationStatus.initial,
        ),
        act: (bloc) => bloc.updateValue('test'),
        expect: () => const [
          FormsFieldState<String>(
            initialValue: 'test',
            value: 'test',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.initial,
          ),
        ],
      );

      blocTest<TextFormsFieldCubit, FormsFieldState<String>>(
        'forms field value status from changed to initial by update initial value',
        build: () => TextFormsFieldCubit(initialValue: 'test'),
        seed: () => FormsFieldState<String>(
          initialValue: 'test',
          value: '',
          valueStatus: FormsFieldValueStatus.changed,
          validationStatus: FormsFieldValidationStatus.initial,
        ),
        act: (bloc) => bloc.updateInitialValue(''),
        expect: () => const [
          FormsFieldState<String>(
            initialValue: '',
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.initial,
          ),
        ],
      );
    },
  );

  group(
    'forms field validation',
    () {
      blocTest<TextFormsFieldCubit, FormsFieldState<String>>(
        'forms field validation pass with no validation',
        build: () => TextFormsFieldCubit(initialValue: ''),
        act: (bloc) => bloc.validate(),
        expect: () => const [
          FormsFieldState<String>(
            initialValue: '',
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.validating,
          ),
          FormsFieldState<String>(
            initialValue: '',
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.pass,
          ),
        ],
      );

      blocTest<TextFormsFieldCubit, FormsFieldState<String>>(
        'forms field validation pass with required validation',
        build: () => TextFormsFieldCubit(
          initialValue: '',
          validation: FormsFieldValidation(validatorList: [
            RequiredFieldValidator(
                triggerTypeList: FieldValidatorTriggerType.values)
          ]),
        ),
        act: (bloc) => bloc.validate(),
        expect: () => const [
          FormsFieldState<String>(
            initialValue: '',
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.validating,
          ),
          FormsFieldState<String>(
            initialValue: '',
            value: '',
            valueStatus: FormsFieldValueStatus.initial,
            validationStatus: FormsFieldValidationStatus.failed,
          ),
        ],
      );
    },
  );
}
