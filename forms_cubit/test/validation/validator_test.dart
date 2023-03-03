import 'package:forms_cubit/forms_cubit.dart';
import 'package:test/test.dart';

void main() {
  group(
    'required forms field validator',
    () {
      group(
        'required forms field validator validate with success',
        () {
          test(
            'nullable object required forms field validator validate with success',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Object?>(triggerTypeList: []);

              expect(Future(() => validator.validate(Object())),
                  completion(isNull));
            },
          );

          test(
            'boolean required forms field validator validate with success',
            () async {
              final validator =
                  FormsFieldRequiredValidator<bool>(triggerTypeList: []);

              expect(
                  Future(() => validator.validate(true)), completion(isNull));
            },
          );

          test(
            'iterable required forms field validator validate with success',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Iterable>(triggerTypeList: []);

              expect(Future(() => validator.validate([Object()])),
                  completion(isNull));
            },
          );

          test(
            'string required forms field validator validate with success',
            () async {
              final validator =
                  FormsFieldRequiredValidator<String>(triggerTypeList: []);

              expect(
                  Future(() => validator.validate('test')), completion(isNull));
            },
          );

          test(
            'map required forms field validator validate with success',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Map>(triggerTypeList: []);

              expect(Future(() => validator.validate({Object(): Object()})),
                  completion(isNull));
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

              expect(Future(() => validator.validate(null)),
                  throwsA(isA<FormsFieldRequiredException>()));
            },
          );

          test(
            'boolean required forms field validator validate with failure',
            () async {
              final validator =
                  FormsFieldRequiredValidator<bool>(triggerTypeList: []);

              expect(Future(() => validator.validate(false)),
                  throwsA(isA<FormsFieldRequiredException>()));
            },
          );

          test(
            'iterable required forms field validator validate with failure',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Iterable>(triggerTypeList: []);

              expect(Future(() => validator.validate([])),
                  throwsA(isA<FormsFieldRequiredException>()));
            },
          );

          test(
            'string required forms field validator validate with failure',
            () async {
              final validator =
                  FormsFieldRequiredValidator<String>(triggerTypeList: []);

              expect(Future(() => validator.validate('')),
                  throwsA(isA<FormsFieldRequiredException>()));
            },
          );

          test(
            'map required forms field validator validate with failure',
            () async {
              final validator =
                  FormsFieldRequiredValidator<Map>(triggerTypeList: []);

              expect(Future(() => validator.validate({})),
                  throwsA(isA<FormsFieldRequiredException>()));
            },
          );
        },
      );
    },
  );
}
