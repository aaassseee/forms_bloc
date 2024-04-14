import 'package:bloc_test/bloc_test.dart';
import 'package:forms_bloc/forms_bloc.dart';
import 'package:test/test.dart';

void main() {
  test(
    'dropdown forms field cubit initial',
    () {
      final dropdownFormsFieldCubit = DropdownFormsFieldCubit<String>(
          initialValue: '',
          itemList: ['', 'a', 'b', 'c', 'd', 'e', 'f'],
          validation: FormsFieldValidation(validatorList: [
            FormsFieldRequiredValidator(
                triggerTypeList: FormsFieldValidatorTriggerType.values)
          ]));
      expect(dropdownFormsFieldCubit.value, '');
      expect(dropdownFormsFieldCubit.initialValue, '');
      expect(
          dropdownFormsFieldCubit.itemList, ['', 'a', 'b', 'c', 'd', 'e', 'f']);
      expect(dropdownFormsFieldCubit.isInitial, isTrue);
      expect(dropdownFormsFieldCubit.isValid, isTrue);
      expect(dropdownFormsFieldCubit.isValidating, isFalse);
    },
  );

  blocTest(
    'dropdown forms field cubit value state',
    build: () => DropdownFormsFieldCubit<String>(
        initialValue: '',
        itemList: ['', 'a', 'b', 'c', 'd', 'e', 'f'],
        validation: FormsFieldValidation(validatorList: [
          FormsFieldRequiredValidator(
              triggerTypeList: FormsFieldValidatorTriggerType.values)
        ])),
    act: (bloc) => bloc.selectValue('a'),
    expect: () => [
      const FormsSelectionFieldState<String>(
        itemState:
            FormsFieldItemState(itemList: ['', 'a', 'b', 'c', 'd', 'e', 'f']),
        valueState: FormsFieldValueState<String>(value: 'a', initialValue: ''),
        validationState: FormsFieldValidationState(
            status: FormsFieldValidationStatus.initial),
      ),
      // state changed from auto validation trigger
      const FormsSelectionFieldState<String>(
        itemState:
            FormsFieldItemState(itemList: ['', 'a', 'b', 'c', 'd', 'e', 'f']),
        valueState: FormsFieldValueState<String>(value: 'a', initialValue: ''),
        validationState: FormsFieldValidationState(
            status: FormsFieldValidationStatus.validating),
      ),
      const FormsSelectionFieldState<String>(
        itemState:
            FormsFieldItemState(itemList: ['', 'a', 'b', 'c', 'd', 'e', 'f']),
        valueState: FormsFieldValueState<String>(value: 'a', initialValue: ''),
        validationState: FormsFieldValidationState(
            status: FormsFieldValidationStatus.validated),
      ),
    ],
    verify: (bloc) {
      expect(bloc.value, 'a');
      expect(bloc.initialValue, '');
      expect(bloc.isInitial, isFalse);
      expect(bloc.isValid, isTrue);
      expect(bloc.isValidating, isFalse);
    },
  );

  blocTest(
    'dropdown forms field cubit item state',
    build: () => DropdownFormsFieldCubit<String>(
        initialValue: '',
        itemList: ['', 'a', 'b', 'c', 'd', 'e', 'f'],
        validation: FormsFieldValidation(validatorList: [
          FormsFieldRequiredValidator(
              triggerTypeList: FormsFieldValidatorTriggerType.values)
        ])),
    act: (bloc) => bloc.addItem('g'),
    expect: () => [
      const FormsSelectionFieldState<String>(
        itemState: FormsFieldItemState(
            itemList: ['', 'a', 'b', 'c', 'd', 'e', 'f', 'g']),
        valueState: FormsFieldValueState<String>(value: '', initialValue: ''),
        validationState: FormsFieldValidationState(
            status: FormsFieldValidationStatus.initial),
      ),
    ],
    verify: (bloc) {
      expect(bloc.value, '');
      expect(bloc.initialValue, '');
      expect(bloc.isInitial, isTrue);
      expect(bloc.isValid, isTrue);
      expect(bloc.isValidating, isFalse);
    },
  );
}
