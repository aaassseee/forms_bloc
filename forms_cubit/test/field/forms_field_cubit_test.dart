import 'package:bloc_test/bloc_test.dart';
import 'package:forms_cubit/forms_cubit.dart';
import 'package:test/test.dart';

import '../mock/error.dart';
import '../mock/forms_field_cubit.dart';
import '../mock/validation.dart';

void main() {
  group(
    'forms field value',
    () {
      blocTest<MockFormsFieldCubit, FormsFieldState<MockObject>>(
        'forms field value from initial to changed by update value',
        build: () => MockFormsFieldCubit(initialValue: MockObject('')),
        act: (bloc) => bloc.updateValue(MockObject('test')),
        expect: () => const [
          FormsFieldState<MockObject>(
            valueState: FormsFieldValueState(
              initialValue: MockObject(''),
              value: MockObject('test'),
            ),
            validationState: FormsFieldValidationState(
                status: FormsFieldValidationStatus.initial),
          ),
        ],
        verify: (bloc) {
          expect(bloc.state.valueState.isInitial, isFalse);
          expect(bloc.isInitial, isFalse);
        },
      );

      blocTest<MockFormsFieldCubit, FormsFieldState<MockObject>>(
        'forms field value from initial to changed by update initial value',
        build: () => MockFormsFieldCubit(initialValue: MockObject('')),
        act: (bloc) => bloc.updateInitialValue(MockObject('test')),
        expect: () => const [
          FormsFieldState<MockObject>(
            valueState: FormsFieldValueState(
              initialValue: MockObject('test'),
              value: MockObject(''),
            ),
            validationState: FormsFieldValidationState(
                status: FormsFieldValidationStatus.initial),
          ),
        ],
        verify: (bloc) {
          expect(bloc.state.valueState.isInitial, isFalse);
          expect(bloc.isInitial, isFalse);
        },
      );

      blocTest<MockFormsFieldCubit, FormsFieldState<MockObject>>(
        'forms field value status from changed to initial by update value',
        build: () => MockFormsFieldCubit(initialValue: MockObject('test')),
        seed: () => FormsFieldState<MockObject>(
          valueState: FormsFieldValueState(
            initialValue: MockObject('test'),
            value: MockObject(''),
          ),
          validationState: FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial),
        ),
        act: (bloc) => bloc.updateValue(MockObject('test')),
        expect: () => const [
          FormsFieldState<MockObject>(
            valueState: FormsFieldValueState(
              initialValue: MockObject('test'),
              value: MockObject('test'),
            ),
            validationState: FormsFieldValidationState(
                status: FormsFieldValidationStatus.initial),
          ),
        ],
        verify: (bloc) {
          expect(bloc.state.valueState.isInitial, isTrue);
          expect(bloc.isInitial, isTrue);
        },
      );

      blocTest<MockFormsFieldCubit, FormsFieldState<MockObject>>(
        'forms field value status from changed to initial by update initial value',
        build: () => MockFormsFieldCubit(initialValue: MockObject('test')),
        seed: () => FormsFieldState<MockObject>(
          valueState: FormsFieldValueState(
            initialValue: MockObject('test'),
            value: MockObject(''),
          ),
          validationState: FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial),
        ),
        act: (bloc) => bloc.updateInitialValue(MockObject('')),
        expect: () => const [
          FormsFieldState<MockObject>(
            valueState: FormsFieldValueState(
              initialValue: MockObject(''),
              value: MockObject(''),
            ),
            validationState: FormsFieldValidationState(
                status: FormsFieldValidationStatus.initial),
          ),
        ],
        verify: (bloc) {
          expect(bloc.state.valueState.isInitial, isTrue);
          expect(bloc.isInitial, isTrue);
        },
      );
    },
  );

  group(
    'forms field validation',
    () {
      group(
        'forms field validation pass',
        () {
          blocTest<MockFormsFieldCubit, FormsFieldState<MockObject>>(
            'forms field validation pass with initial value and no validation',
            build: () => MockFormsFieldCubit(initialValue: MockObject('')),
            act: (bloc) => bloc.validate(),
            expect: () => const [
              FormsFieldState<MockObject>(
                valueState: FormsFieldValueState(
                  initialValue: MockObject(''),
                  value: MockObject(''),
                ),
                validationState: FormsFieldValidationState(
                    status: FormsFieldValidationStatus.validating),
              ),
              FormsFieldState<MockObject>(
                valueState: FormsFieldValueState(
                  initialValue: MockObject(''),
                  value: MockObject(''),
                ),
                validationState: FormsFieldValidationState(
                    status: FormsFieldValidationStatus.validated),
              ),
            ],
            verify: (bloc) {
              expect(bloc.state.validationState.isValid, isTrue);
              expect(bloc.isValid, isTrue);
              expect(bloc.state.validationState.status,
                  FormsFieldValidationStatus.validated);
            },
          );

          blocTest<MockFormsFieldCubit, FormsFieldState<MockObject>>(
            'forms field validation pass with initial value and mock validation',
            build: () => MockFormsFieldCubit(
              initialValue: MockObject('test'),
              validation: MockFormsFieldValidation(),
            ),
            act: (bloc) => bloc.validate(),
            expect: () => [
              FormsFieldState<MockObject>(
                valueState: FormsFieldValueState(
                  initialValue: MockObject('test'),
                  value: MockObject('test'),
                ),
                validationState: FormsFieldValidationState(
                    status: FormsFieldValidationStatus.validating),
              ),
              FormsFieldState<MockObject>(
                valueState: FormsFieldValueState(
                  initialValue: MockObject('test'),
                  value: MockObject('test'),
                ),
                validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validated,
                ),
              ),
            ],
            verify: (bloc) {
              expect(bloc.state.validationState.isValid, isTrue);
              expect(bloc.isValid, isTrue);
              expect(bloc.state.validationState.status,
                  FormsFieldValidationStatus.validated);
            },
          );

          blocTest<MockFormsFieldCubit, FormsFieldState<MockObject>>(
            'forms field validation pass with initial value and mock async validation',
            build: () => MockFormsFieldCubit(
              initialValue: MockObject('test'),
              validation: MockAsyncFormsFieldValidation(),
            ),
            act: (bloc) => bloc.validate(),
            expect: () => [
              FormsFieldState<MockObject>(
                valueState: FormsFieldValueState(
                  initialValue: MockObject('test'),
                  value: MockObject('test'),
                ),
                validationState: FormsFieldValidationState(
                    status: FormsFieldValidationStatus.validating),
              ),
              FormsFieldState<MockObject>(
                valueState: FormsFieldValueState(
                  initialValue: MockObject('test'),
                  value: MockObject('test'),
                ),
                validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validated,
                ),
              ),
            ],
            verify: (bloc) {
              expect(bloc.state.validationState.isValid, isTrue);
              expect(bloc.isValid, isTrue);
              expect(bloc.state.validationState.status,
                  FormsFieldValidationStatus.validated);
            },
          );
        },
      );

      group(
        'forms field validation failure',
        () {
          blocTest<MockFormsFieldCubit, FormsFieldState<MockObject>>(
            'forms field validation failure with initial value and mock failure validation',
            build: () => MockFormsFieldCubit(
              initialValue: MockObject('test'),
              validation: MockFailureFormsFieldValidation(),
            ),
            act: (bloc) => bloc.validate(),
            expect: () => [
              FormsFieldState<MockObject>(
                valueState: FormsFieldValueState(
                  initialValue: MockObject('test'),
                  value: MockObject('test'),
                ),
                validationState: FormsFieldValidationState(
                    status: FormsFieldValidationStatus.validating),
              ),
              FormsFieldState<MockObject>(
                valueState: FormsFieldValueState(
                  initialValue: MockObject('test'),
                  value: MockObject('test'),
                ),
                validationState: FormsFieldValidationState(
                  error: MockFormsFieldValidationException(),
                  status: FormsFieldValidationStatus.validated,
                ),
              ),
            ],
            verify: (bloc) {
              expect(bloc.state.validationState.isValid, isFalse);
              expect(bloc.isValid, isFalse);
              expect(bloc.state.validationState.status,
                  FormsFieldValidationStatus.validated);
            },
          );

          blocTest<MockFormsFieldCubit, FormsFieldState<MockObject>>(
            'forms field validation failure with initial value and mock failure async validation',
            build: () => MockFormsFieldCubit(
              initialValue: MockObject('test'),
              validation: MockFailureAsyncFormsFieldValidation(),
            ),
            act: (bloc) => bloc.validate(),
            expect: () => [
              FormsFieldState<MockObject>(
                valueState: FormsFieldValueState(
                  initialValue: MockObject('test'),
                  value: MockObject('test'),
                ),
                validationState: FormsFieldValidationState(
                    status: FormsFieldValidationStatus.validating),
              ),
              FormsFieldState<MockObject>(
                valueState: FormsFieldValueState(
                  initialValue: MockObject('test'),
                  value: MockObject('test'),
                ),
                validationState: FormsFieldValidationState(
                  error: MockFormsFieldValidationException(),
                  status: FormsFieldValidationStatus.validated,
                ),
              ),
            ],
            verify: (bloc) {
              expect(bloc.state.validationState.isValid, isFalse);
              expect(bloc.isValid, isFalse);
              expect(bloc.state.validationState.status,
                  FormsFieldValidationStatus.validated);
            },
          );

          test(
            'forms field validation failure with validate during validating',
            () {
              final formsFieldCubit = MockFormsFieldCubit(
                  validation: MockFailureAsyncFormsFieldValidation());
              expect(
                  Future.wait([
                    Future(() => formsFieldCubit.validate()),
                    Future(() => formsFieldCubit.validate()),
                  ]),
                  throwsA(isA<FormsFieldValidatingException>()));
            },
          );
        },
      );
    },
  );
}
