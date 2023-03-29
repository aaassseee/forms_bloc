import 'package:bloc_test/bloc_test.dart';
import 'package:forms_cubit/forms_cubit.dart';
import 'package:test/test.dart';

void main() {
  test(
    'text forms field cubit initial',
    () {
      final textFormsFieldCubit = TextFormsFieldCubit(
          initialValue: '',
          validation: FormsFieldValidation(validatorList: [
            FormsFieldRequiredValidator(
                triggerTypeList: FormsFieldValidatorTriggerType.values)
          ]));
      expect(textFormsFieldCubit.value, '');
      expect(textFormsFieldCubit.initialValue, '');
      expect(textFormsFieldCubit.isInitial, isTrue);
      expect(textFormsFieldCubit.isValid, isTrue);
      expect(textFormsFieldCubit.isValidating, isFalse);
    },
  );

  blocTest(
    'text forms field cubit state',
    build: () => TextFormsFieldCubit(
        initialValue: '',
        validation: FormsFieldValidation(validatorList: [
          FormsFieldRequiredValidator(
              triggerTypeList: FormsFieldValidatorTriggerType.values)
        ])),
    act: (bloc) => bloc.updateValue('test'),
    expect: () => [
      FormsFieldState(
        valueState:
            FormsFieldValueState<String>(value: 'test', initialValue: ''),
        validationState: FormsFieldValidationState(
            status: FormsFieldValidationStatus.initial),
      ),
      // state changed from auto validation trigger
      FormsFieldState(
        valueState:
            FormsFieldValueState<String>(value: 'test', initialValue: ''),
        validationState: FormsFieldValidationState(
            status: FormsFieldValidationStatus.validating),
      ),
      FormsFieldState(
        valueState:
            FormsFieldValueState<String>(value: 'test', initialValue: ''),
        validationState: FormsFieldValidationState(
            status: FormsFieldValidationStatus.validated),
      ),
    ],
    verify: (bloc) {
      expect(bloc.value, 'test');
      expect(bloc.initialValue, '');
      expect(bloc.isInitial, isFalse);
      expect(bloc.isValid, isTrue);
      expect(bloc.isValidating, isFalse);
    },
  );
}
