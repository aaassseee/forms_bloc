import 'package:forms_cubit/forms_cubit.dart';
import 'package:test/test.dart';

void main() {
  test(
    'text forms field cubit',
    () {
      final textFormsFieldCubit = TextFormsFieldCubit(
          initialValue: '',
          validation: FormsFieldValidation(validatorList: [
            FormsFieldRequiredValidator(
                triggerTypeList: FieldValidatorTriggerType.values)
          ]));
      expect(textFormsFieldCubit.value, '');
      expect(textFormsFieldCubit.initialValue, '');
      expect(textFormsFieldCubit.isInitial, isTrue);
      expect(textFormsFieldCubit.isValid, isTrue);
      expect(textFormsFieldCubit.isValidating, isFalse);

      textFormsFieldCubit.updateValue('test');
      expect(textFormsFieldCubit.value, 'test');
      expect(textFormsFieldCubit.initialValue, '');
      expect(textFormsFieldCubit.isInitial, isFalse);
      expect(textFormsFieldCubit.isValid, isTrue);
      expect(textFormsFieldCubit.isValidating, isFalse);
    },
  );
}
