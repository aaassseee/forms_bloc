import 'package:forms_cubit/forms_cubit.dart';
import 'package:test/test.dart';

void main() {
  group(
    'required forms field validator',
    () {
      test('required forms field validator initial', () {
        final validator =
            FormsFieldRequiredValidator<Object?>(triggerTypeList: []);
        expect(validator.hasValidate, false);
        expect(validator.exception, null);
      });

      group(
        'required forms field validator validate with success',
        () {
          test(
            'nullable object required forms field validator validate with success',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Object?>(triggerTypeList: []);
              await validator.validate(Object());
              expect(validator.exception, isNull);
            },
          );

          test(
            'boolean required forms field validator validate with success',
            () async {
              final validator =
                  FormsFieldRequiredValidator<bool>(triggerTypeList: []);
              await validator.validate(true);
              expect(validator.exception, isNull);
            },
          );

          test(
            'iterable required forms field validator validate with success',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Iterable>(triggerTypeList: []);

              await validator.validate([Object()]);
              expect(validator.exception, isNull);
            },
          );

          test(
            'string required forms field validator validate with success',
            () async {
              final validator =
                  FormsFieldRequiredValidator<String>(triggerTypeList: []);
              await validator.validate('test');
              expect(validator.exception, isNull);
            },
          );

          test(
            'map required forms field validator validate with success',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Map>(triggerTypeList: []);
              await validator.validate({Object(): Object()});
              expect(validator.exception, isNull);
            },
          );
        },
      );

      group(
        'required forms field validator validate with failure',
        () {
          test(
            'nullable object required forms field validator validate with failure',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Object?>(triggerTypeList: []);
              await validator.validate(null);
              expect(validator.exception, isA<FormsFieldRequiredException>());
            },
          );

          test(
            'boolean required forms field validator validate with failure',
            () async {
              final validator =
                  FormsFieldRequiredValidator<bool>(triggerTypeList: []);
              await validator.validate(false);
              expect(validator.exception, isA<FormsFieldRequiredException>());
            },
          );

          test(
            'iterable required forms field validator validate with failure',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Iterable>(triggerTypeList: []);
              await validator.validate([]);
              expect(validator.exception, isA<FormsFieldRequiredException>());
            },
          );

          test(
            'string required forms field validator validate with failure',
            () async {
              final validator =
                  FormsFieldRequiredValidator<String>(triggerTypeList: []);
              await validator.validate('');
              expect(validator.exception, isA<FormsFieldRequiredException>());
            },
          );

          test(
            'map required forms field validator validate with failure',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Map>(triggerTypeList: []);
              await validator.validate({});
              expect(validator.exception, isA<FormsFieldRequiredException>());
            },
          );
        },
      );
    },
  );

  group(
    'validator cancel validate',
    () {
      test(
        'cancel validate',
        () async {
          final validator =
              FormsFieldRequiredValidator<Object?>(triggerTypeList: []);
          validator.validate(null);
          await validator.cancel();
          expect(validator.validateOperation?.isCanceled, true);
        },
      );
    },
  );
}
