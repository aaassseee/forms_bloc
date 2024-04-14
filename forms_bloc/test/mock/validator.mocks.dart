// Mocks generated by Mockito 5.4.4 from annotations
// in forms_bloc/test/mock/validator.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:async/async.dart' as _i3;
import 'package:forms_bloc/field/model/field_exception.dart' as _i4;
import 'package:forms_bloc/field/validation/validation.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [FormsFieldValidator].
///
/// See the documentation for Mockito's code generation for more information.
class MockFormsFieldValidator<T> extends _i1.Mock
    implements _i2.FormsFieldValidator<T> {
  @override
  Iterable<_i2.FormsFieldValidatorTriggerType> get triggerTypeList =>
      (super.noSuchMethod(
        Invocation.getter(#triggerTypeList),
        returnValue: <_i2.FormsFieldValidatorTriggerType>[],
        returnValueForMissingStub: <_i2.FormsFieldValidatorTriggerType>[],
      ) as Iterable<_i2.FormsFieldValidatorTriggerType>);

  @override
  set validateOperation(
          _i3.CancelableOperation<_i4.FormsFieldException?>?
              _validateOperation) =>
      super.noSuchMethod(
        Invocation.setter(
          #validateOperation,
          _validateOperation,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hasValidate => (super.noSuchMethod(
        Invocation.getter(#hasValidate),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i5.Future<void> validate(T? value) => (super.noSuchMethod(
        Invocation.method(
          #validate,
          [value],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<_i4.FormsFieldException?> onValidate(T? value) =>
      (super.noSuchMethod(
        Invocation.method(
          #onValidate,
          [value],
        ),
        returnValue: _i5.Future<_i4.FormsFieldException?>.value(),
        returnValueForMissingStub: _i5.Future<_i4.FormsFieldException?>.value(),
      ) as _i5.Future<_i4.FormsFieldException?>);

  @override
  _i5.Future<void>? cancel() => (super.noSuchMethod(
        Invocation.method(
          #cancel,
          [],
        ),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>?);

  @override
  void reset() => super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
