import 'package:forms_bloc/forms_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/validator.dart';

void main() {
  group('validation', () {
    final mockValidator = MockFormsFieldValidator();

    group('validation validate', () {
      setUp(() {
        when(mockValidator.hasValidate).thenReturn(true);
        when(mockValidator.exception).thenReturn(null);
        when(mockValidator.validate(any));
      });

      tearDown(() {
        reset(mockValidator);
      });

      test('validation pass', () {
        final validation = FormsFieldValidation(validatorList: [mockValidator]);
        validation.validate('a');
        expect(validation.isValid, true);
        expect(validation.errorList, []);
      });
    });

    group('validation validator', () {
      test('validation initial validator', () {
        final validation = FormsFieldValidation();
        expect(validation.validatorList, isEmpty);
      });

      test('validation add validator', () {
        final validation = FormsFieldValidation(validatorList: [mockValidator]);
        final mockValidator2 = MockFormsFieldValidator();
        validation.addValidator(mockValidator2);
        expect(validation.validatorList, [mockValidator, mockValidator2]);
      });

      test('validation add validator list', () {
        final validation = FormsFieldValidation(validatorList: [mockValidator]);
        final mockValidator2 = MockFormsFieldValidator();
        final mockValidator3 = MockFormsFieldValidator();
        final validatorList = [mockValidator2, mockValidator3];
        validation.addValidatorList(validatorList);
        expect(validation.validatorList,
            [mockValidator, mockValidator2, mockValidator3]);
      });

      test('validation remove validator', () {
        final validation = FormsFieldValidation(validatorList: [mockValidator]);
        validation.removeValidator(mockValidator);
        expect(validation.validatorList, []);
      });

      test('validation insert validator', () {
        final validation = FormsFieldValidation(validatorList: [mockValidator]);
        final mockValidator2 = MockFormsFieldValidator();
        validation.insertValidator(0, mockValidator2);
        expect(validation.validatorList, [mockValidator2, mockValidator]);
      });

      test('validation insert validator list', () {
        final validation = FormsFieldValidation(validatorList: [mockValidator]);
        final mockValidator2 = MockFormsFieldValidator();
        final mockValidator3 = MockFormsFieldValidator();
        final validatorList = [mockValidator2, mockValidator3];
        validation.insertValidatorList(0, validatorList);
        expect(validation.validatorList,
            [mockValidator2, mockValidator3, mockValidator]);
      });

      test('validation update validator list', () {
        final validation = FormsFieldValidation(validatorList: [mockValidator]);
        final mockValidator2 = MockFormsFieldValidator();
        final mockValidator3 = MockFormsFieldValidator();
        final validatorList = [mockValidator2, mockValidator3];
        validation.updateValidatorList(validatorList);
        expect(validation.validatorList, [mockValidator2, mockValidator3]);
      });
    });
  });
}
