import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_cubit/forms_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/error.dart';
import '../../mock/validation.dart';

void main() {
  group('forms field', () {
    group('forms field value', () {
      blocTest<SampleFormsFieldCubit, FormsFieldState<SampleObject>>(
        'forms field value from initial to changed by update value',
        build: () =>
            SampleFormsFieldCubit(initialValue: const SampleObject('')),
        act: (bloc) => bloc.updateValue(const SampleObject('test')),
        expect: () => const [
          FormsFieldState<SampleObject>(
            valueState: FormsFieldValueState(
              initialValue: SampleObject(''),
              value: SampleObject('test'),
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

      blocTest<SampleFormsFieldCubit, FormsFieldState<SampleObject>>(
        'forms field value from initial to changed by update initial value',
        build: () =>
            SampleFormsFieldCubit(initialValue: const SampleObject('')),
        act: (bloc) => bloc.updateInitialValue(const SampleObject('test')),
        expect: () => const [
          FormsFieldState<SampleObject>(
            valueState: FormsFieldValueState(
              initialValue: SampleObject('test'),
              value: SampleObject(''),
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

      blocTest<SampleFormsFieldCubit, FormsFieldState<SampleObject>>(
        'forms field value status from changed to initial by update value',
        build: () =>
            SampleFormsFieldCubit(initialValue: const SampleObject('test')),
        seed: () => const FormsFieldState<SampleObject>(
          valueState: FormsFieldValueState(
            initialValue: SampleObject('test'),
            value: SampleObject(''),
          ),
          validationState: FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial),
        ),
        act: (bloc) => bloc.updateValue(const SampleObject('test')),
        expect: () => const [
          FormsFieldState<SampleObject>(
            valueState: FormsFieldValueState(
              initialValue: SampleObject('test'),
              value: SampleObject('test'),
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

      blocTest<SampleFormsFieldCubit, FormsFieldState<SampleObject>>(
        'forms field value status from changed to initial by update initial value',
        build: () =>
            SampleFormsFieldCubit(initialValue: const SampleObject('test')),
        seed: () => const FormsFieldState<SampleObject>(
          valueState: FormsFieldValueState(
            initialValue: SampleObject('test'),
            value: SampleObject(''),
          ),
          validationState: FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial),
        ),
        act: (bloc) => bloc.updateInitialValue(const SampleObject('')),
        expect: () => const [
          FormsFieldState<SampleObject>(
            valueState: FormsFieldValueState(
              initialValue: SampleObject(''),
              value: SampleObject(''),
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
    });

    group('forms field validation', () {
      final mockValidation = MockFormsFieldValidation<SampleObject>();

      group('forms field validation pass', () {
        setUp(() {
          when(mockValidation.isValid).thenReturn(true);
          when(mockValidation.errorList).thenReturn([]);
        });

        tearDown(() {
          reset(mockValidation);
        });

        blocTest<SampleFormsFieldCubit, FormsFieldState<SampleObject>>(
          'forms field validation pass with initial value and no validation',
          build: () =>
              SampleFormsFieldCubit(initialValue: const SampleObject('')),
          act: (bloc) => bloc.validate(),
          expect: () => const [
            FormsFieldState<SampleObject>(
              valueState: FormsFieldValueState(
                initialValue: SampleObject(''),
                value: SampleObject(''),
              ),
              validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validating),
            ),
            FormsFieldState<SampleObject>(
              valueState: FormsFieldValueState(
                initialValue: SampleObject(''),
                value: SampleObject(''),
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

        blocTest<SampleFormsFieldCubit, FormsFieldState<SampleObject>>(
          'forms field validation pass with initial value and mock validation',
          setUp: () {
            when(mockValidation.validate(any)).thenAnswer((_) => null);
          },
          build: () => SampleFormsFieldCubit(
              initialValue: const SampleObject('test'),
              validation: mockValidation),
          act: (bloc) => bloc.validate(),
          expect: () => [
            const FormsFieldState<SampleObject>(
              valueState: FormsFieldValueState(
                initialValue: SampleObject('test'),
                value: SampleObject('test'),
              ),
              validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validating),
            ),
            const FormsFieldState<SampleObject>(
              valueState: FormsFieldValueState(
                initialValue: SampleObject('test'),
                value: SampleObject('test'),
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

        blocTest<SampleFormsFieldCubit, FormsFieldState<SampleObject>>(
          'forms field validation pass with initial value and mock async validation',
          setUp: () => when(mockValidation.validate(any)).thenAnswer(
              (_) async =>
                  await Future.delayed(const Duration(milliseconds: 250))),
          build: () => SampleFormsFieldCubit(
            initialValue: const SampleObject('test'),
            validation: mockValidation,
          ),
          act: (bloc) => bloc.validate(),
          expect: () => [
            const FormsFieldState<SampleObject>(
              valueState: FormsFieldValueState(
                initialValue: SampleObject('test'),
                value: SampleObject('test'),
              ),
              validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validating),
            ),
            const FormsFieldState<SampleObject>(
              valueState: FormsFieldValueState(
                initialValue: SampleObject('test'),
                value: SampleObject('test'),
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
      });

      group('forms field validation failure', () {
        setUp(() {
          when(mockValidation.isValid).thenReturn(false);
          when(mockValidation.errorList)
              .thenReturn([FakeFormsFieldValidationException()]);
        });

        tearDown(() {
          reset(mockValidation);
        });

        blocTest<SampleFormsFieldCubit, FormsFieldState<SampleObject>>(
          'forms field validation failure with initial value and mock failure validation',
          setUp: () =>
              when(mockValidation.validate(any)).thenAnswer((_) => null),
          build: () => SampleFormsFieldCubit(
            initialValue: const SampleObject('test'),
            validation: mockValidation,
          ),
          act: (bloc) => bloc.validate(),
          expect: () => [
            const FormsFieldState<SampleObject>(
              valueState: FormsFieldValueState(
                initialValue: SampleObject('test'),
                value: SampleObject('test'),
              ),
              validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validating),
            ),
            FormsFieldState<SampleObject>(
              valueState: const FormsFieldValueState(
                initialValue: SampleObject('test'),
                value: SampleObject('test'),
              ),
              validationState: FormsFieldValidationState(
                error: [FakeFormsFieldValidationException()],
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

        blocTest<SampleFormsFieldCubit, FormsFieldState<SampleObject>>(
          'forms field validation failure with initial value and mock failure async validation',
          setUp: () => when(mockValidation.validate(any)).thenAnswer(
              (_) async =>
                  await Future.delayed(const Duration(milliseconds: 250))),
          build: () => SampleFormsFieldCubit(
            initialValue: const SampleObject('test'),
            validation: mockValidation,
          ),
          act: (bloc) => bloc.validate(),
          expect: () => [
            const FormsFieldState<SampleObject>(
              valueState: FormsFieldValueState(
                initialValue: SampleObject('test'),
                value: SampleObject('test'),
              ),
              validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validating),
            ),
            FormsFieldState<SampleObject>(
              valueState: const FormsFieldValueState(
                initialValue: SampleObject('test'),
                value: SampleObject('test'),
              ),
              validationState: FormsFieldValidationState(
                error: [FakeFormsFieldValidationException()],
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
      });
    });
  });

  group('forms single selection field', () {
    group('forms single selection field value', () {
      blocTest<SampleFormsSingleSelectionFieldCubit,
          FormsSelectionFieldState<SampleObject>>(
        'forms single selection field value from initial to changed by update value',
        build: () => SampleFormsSingleSelectionFieldCubit(
            initialValue: const SampleObject('')),
        act: (bloc) => bloc.selectValue(const SampleObject('a')),
        expect: () => const [
          FormsSelectionFieldState<SampleObject>(
            itemState: FormsFieldItemState(itemList: [
              SampleObject(''),
              SampleObject('a'),
              SampleObject('b'),
            ]),
            valueState: FormsFieldValueState(
              initialValue: SampleObject(''),
              value: SampleObject('a'),
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

      blocTest<SampleFormsSingleSelectionFieldCubit,
          FormsSelectionFieldState<SampleObject>>(
        'forms single selection field value from initial to changed by update initial value',
        build: () => SampleFormsSingleSelectionFieldCubit(
            initialValue: const SampleObject('')),
        act: (bloc) => bloc.updateInitialValue(const SampleObject('a')),
        expect: () => const [
          FormsSelectionFieldState<SampleObject>(
            itemState: FormsFieldItemState(itemList: [
              SampleObject(''),
              SampleObject('a'),
              SampleObject('b'),
            ]),
            valueState: FormsFieldValueState(
              initialValue: SampleObject('a'),
              value: SampleObject(''),
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

      blocTest<SampleFormsSingleSelectionFieldCubit,
          FormsSelectionFieldState<SampleObject>>(
        'forms single selection field value status from changed to initial by update value',
        build: () => SampleFormsSingleSelectionFieldCubit(
            initialValue: const SampleObject('test')),
        seed: () => const FormsSelectionFieldState<SampleObject>(
          itemState: FormsFieldItemState(itemList: [
            SampleObject(''),
            SampleObject('a'),
            SampleObject('b'),
          ]),
          valueState: FormsFieldValueState(
            initialValue: SampleObject('a'),
            value: SampleObject(''),
          ),
          validationState: FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial),
        ),
        act: (bloc) => bloc.selectValue(const SampleObject('a')),
        expect: () => const [
          FormsSelectionFieldState<SampleObject>(
            itemState: FormsFieldItemState(itemList: [
              SampleObject(''),
              SampleObject('a'),
              SampleObject('b'),
            ]),
            valueState: FormsFieldValueState(
              initialValue: SampleObject('a'),
              value: SampleObject('a'),
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

      blocTest<SampleFormsSingleSelectionFieldCubit,
          FormsSelectionFieldState<SampleObject>>(
        'forms single selection field value status from changed to initial by update initial value',
        build: () => SampleFormsSingleSelectionFieldCubit(
            initialValue: const SampleObject('a')),
        seed: () => const FormsSelectionFieldState<SampleObject>(
          itemState: FormsFieldItemState(itemList: [
            SampleObject(''),
            SampleObject('a'),
            SampleObject('b'),
          ]),
          valueState: FormsFieldValueState(
            initialValue: SampleObject('a'),
            value: SampleObject(''),
          ),
          validationState: FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial),
        ),
        act: (bloc) => bloc.updateInitialValue(const SampleObject('')),
        expect: () => const [
          FormsSelectionFieldState<SampleObject>(
            itemState: FormsFieldItemState(itemList: [
              SampleObject(''),
              SampleObject('a'),
              SampleObject('b'),
            ]),
            valueState: FormsFieldValueState(
              initialValue: SampleObject(''),
              value: SampleObject(''),
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

      test('forms single selection field select not in item value', () {
        final bloc = SampleFormsSingleSelectionFieldCubit(
            initialValue: const SampleObject('a'));
        expect(() => bloc.selectValue(const SampleObject('c')),
            throwsA(isA<FormsSelectionFieldNotInItemListException>()));
      });
    });

    group('forms single selection field validation', () {
      final mockValidation = MockFormsFieldValidation<SampleObject>();

      group('forms single selection field validation pass', () {
        setUp(() {
          when(mockValidation.isValid).thenReturn(true);
          when(mockValidation.errorList).thenReturn([]);
        });

        tearDown(() {
          reset(mockValidation);
        });

        blocTest<SampleFormsSingleSelectionFieldCubit,
            FormsSelectionFieldState<SampleObject>>(
          'forms single selection field validation pass with initial value and no validation',
          build: () => SampleFormsSingleSelectionFieldCubit(
              initialValue: const SampleObject('')),
          act: (bloc) => bloc.validate(),
          expect: () => const [
            FormsSelectionFieldState<SampleObject>(
              itemState: FormsFieldItemState(itemList: [
                SampleObject(''),
                SampleObject('a'),
                SampleObject('b'),
              ]),
              valueState: FormsFieldValueState(
                initialValue: SampleObject(''),
                value: SampleObject(''),
              ),
              validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validating),
            ),
            FormsSelectionFieldState<SampleObject>(
              itemState: FormsFieldItemState(itemList: [
                SampleObject(''),
                SampleObject('a'),
                SampleObject('b'),
              ]),
              valueState: FormsFieldValueState(
                initialValue: SampleObject(''),
                value: SampleObject(''),
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

        blocTest<SampleFormsSingleSelectionFieldCubit,
            FormsSelectionFieldState<SampleObject>>(
          'forms single selection field validation pass with initial value and mock validation',
          setUp: () {
            when(mockValidation.validate(any)).thenAnswer((_) => null);
          },
          build: () => SampleFormsSingleSelectionFieldCubit(
              initialValue: const SampleObject('a'),
              validation: mockValidation),
          act: (bloc) => bloc.validate(),
          expect: () => [
            const FormsSelectionFieldState<SampleObject>(
              itemState: FormsFieldItemState(itemList: [
                SampleObject(''),
                SampleObject('a'),
                SampleObject('b'),
              ]),
              valueState: FormsFieldValueState(
                initialValue: SampleObject('a'),
                value: SampleObject('a'),
              ),
              validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validating),
            ),
            const FormsSelectionFieldState<SampleObject>(
              itemState: FormsFieldItemState(itemList: [
                SampleObject(''),
                SampleObject('a'),
                SampleObject('b'),
              ]),
              valueState: FormsFieldValueState(
                initialValue: SampleObject('a'),
                value: SampleObject('a'),
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

        blocTest<SampleFormsSingleSelectionFieldCubit,
            FormsSelectionFieldState<SampleObject>>(
          'forms single selection field validation pass with initial value and mock async validation',
          setUp: () => when(mockValidation.validate(any)).thenAnswer(
              (_) async =>
                  await Future.delayed(const Duration(milliseconds: 250))),
          build: () => SampleFormsSingleSelectionFieldCubit(
            initialValue: const SampleObject('a'),
            validation: mockValidation,
          ),
          act: (bloc) => bloc.validate(),
          expect: () => [
            const FormsSelectionFieldState<SampleObject>(
              itemState: FormsFieldItemState(itemList: [
                SampleObject(''),
                SampleObject('a'),
                SampleObject('b'),
              ]),
              valueState: FormsFieldValueState(
                initialValue: SampleObject('a'),
                value: SampleObject('a'),
              ),
              validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validating),
            ),
            const FormsSelectionFieldState<SampleObject>(
              itemState: FormsFieldItemState(itemList: [
                SampleObject(''),
                SampleObject('a'),
                SampleObject('b'),
              ]),
              valueState: FormsFieldValueState(
                initialValue: SampleObject('a'),
                value: SampleObject('a'),
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
      });

      group('forms single selection field validation failure', () {
        setUp(() {
          when(mockValidation.isValid).thenReturn(false);
          when(mockValidation.errorList)
              .thenReturn([FakeFormsFieldValidationException()]);
        });

        tearDown(() {
          reset(mockValidation);
        });

        blocTest<SampleFormsSingleSelectionFieldCubit,
            FormsSelectionFieldState<SampleObject>>(
          'forms single selection field validation failure with initial value and mock failure validation',
          setUp: () =>
              when(mockValidation.validate(any)).thenAnswer((_) => null),
          build: () => SampleFormsSingleSelectionFieldCubit(
            initialValue: const SampleObject('a'),
            validation: mockValidation,
          ),
          act: (bloc) => bloc.validate(),
          expect: () => [
            const FormsSelectionFieldState<SampleObject>(
              itemState: FormsFieldItemState(itemList: [
                SampleObject(''),
                SampleObject('a'),
                SampleObject('b'),
              ]),
              valueState: FormsFieldValueState(
                initialValue: SampleObject('a'),
                value: SampleObject('a'),
              ),
              validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validating),
            ),
            FormsSelectionFieldState<SampleObject>(
              itemState: const FormsFieldItemState(itemList: [
                SampleObject(''),
                SampleObject('a'),
                SampleObject('b'),
              ]),
              valueState: const FormsFieldValueState(
                initialValue: SampleObject('a'),
                value: SampleObject('a'),
              ),
              validationState: FormsFieldValidationState(
                error: [FakeFormsFieldValidationException()],
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

        blocTest<SampleFormsSingleSelectionFieldCubit,
            FormsSelectionFieldState<SampleObject>>(
          'forms single selection field validation failure with initial value and mock failure async validation',
          setUp: () => when(mockValidation.validate(any)).thenAnswer(
              (_) async =>
                  await Future.delayed(const Duration(milliseconds: 250))),
          build: () => SampleFormsSingleSelectionFieldCubit(
            initialValue: const SampleObject('a'),
            validation: mockValidation,
          ),
          act: (bloc) => bloc.validate(),
          expect: () => [
            const FormsSelectionFieldState<SampleObject>(
              itemState: FormsFieldItemState(itemList: [
                SampleObject(''),
                SampleObject('a'),
                SampleObject('b'),
              ]),
              valueState: FormsFieldValueState(
                initialValue: SampleObject('a'),
                value: SampleObject('a'),
              ),
              validationState: FormsFieldValidationState(
                  status: FormsFieldValidationStatus.validating),
            ),
            FormsSelectionFieldState<SampleObject>(
              itemState: const FormsFieldItemState(itemList: [
                SampleObject(''),
                SampleObject('a'),
                SampleObject('b'),
              ]),
              valueState: const FormsFieldValueState(
                initialValue: SampleObject('a'),
                value: SampleObject('a'),
              ),
              validationState: FormsFieldValidationState(
                error: [FakeFormsFieldValidationException()],
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
      });
    });

    group('forms single selection field item', () {
      blocTest<SampleFormsSingleSelectionFieldCubit,
          FormsSelectionFieldState<SampleObject>>(
        'forms single selection field item add item',
        build: () => SampleFormsSingleSelectionFieldCubit(
          initialValue: const SampleObject(''),
        ),
        act: (bloc) => bloc.addItem(const SampleObject('c')),
        expect: () => [
          const FormsSelectionFieldState<SampleObject>(
            itemState: FormsFieldItemState(itemList: [
              SampleObject(''),
              SampleObject('a'),
              SampleObject('b'),
              SampleObject('c'),
            ]),
            valueState: FormsFieldValueState(
              initialValue: SampleObject(''),
              value: SampleObject(''),
            ),
            validationState: FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial,
            ),
          ),
        ],
      );

      blocTest<SampleFormsSingleSelectionFieldCubit,
          FormsSelectionFieldState<SampleObject>>(
        'forms single selection field item remove item',
        build: () => SampleFormsSingleSelectionFieldCubit(
          initialValue: const SampleObject(''),
        ),
        act: (bloc) => bloc.removeItem(const SampleObject('b')),
        expect: () => [
          const FormsSelectionFieldState<SampleObject>(
            itemState: FormsFieldItemState(itemList: [
              SampleObject(''),
              SampleObject('a'),
            ]),
            valueState: FormsFieldValueState(
              initialValue: SampleObject(''),
              value: SampleObject(''),
            ),
            validationState: FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial,
            ),
          ),
        ],
      );

      blocTest<SampleFormsSingleSelectionFieldCubit,
          FormsSelectionFieldState<SampleObject>>(
        'forms single selection field item update item list',
        build: () => SampleFormsSingleSelectionFieldCubit(
          initialValue: const SampleObject(''),
        ),
        act: (bloc) => bloc
            .updateItemList([const SampleObject('c'), const SampleObject('d')]),
        expect: () => [
          const FormsSelectionFieldState<SampleObject>(
            itemState: FormsFieldItemState(itemList: [
              SampleObject('c'),
              SampleObject('d'),
            ]),
            valueState: FormsFieldValueState(
              initialValue: SampleObject(''),
              value: SampleObject(''),
            ),
            validationState: FormsFieldValidationState(
              status: FormsFieldValidationStatus.initial,
            ),
          ),
        ],
      );
    });
  });
}

class SampleObject extends Equatable {
  const SampleObject(this.mockParameter);

  final Object mockParameter;

  @override
  List<Object?> get props => [mockParameter];
}

class SampleFormsFieldCubit extends FormsFieldCubit<SampleObject> {
  SampleFormsFieldCubit({
    super.initialValue = const SampleObject(''),
    super.validation,
  });
}

class SampleFormsSingleSelectionFieldCubit
    extends FormsSingleSelectionFieldCubit<SampleObject> {
  SampleFormsSingleSelectionFieldCubit({
    super.initialValue = const SampleObject(''),
    super.itemList = const [
      SampleObject(''),
      SampleObject('a'),
      SampleObject('b'),
    ],
    super.validation,
  });
}
