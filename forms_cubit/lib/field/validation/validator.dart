part of 'validation.dart';

enum FormsFieldValidatorTriggerType {
  initial,
  valueChanged,
  unfocus,
}

abstract class FormsFieldValidator<T> {
  FormsFieldValidator({required this.triggerTypeList});

  final Iterable<FormsFieldValidatorTriggerType> triggerTypeList;

  bool _hasValidate = false;

  bool get hasValidate => _hasValidate;

  FormsFieldException? _exception;

  FormsFieldException? get exception => _exception;

  CancelableOperation<FormsFieldException?>? validateOperation;

  Future<void> validate(T value) async {
    reset();
    validateOperation = CancelableOperation.fromFuture(onValidate(value));
    final validationResult = await validateOperation?.value;
    _exception = validationResult;
    _hasValidate = true;
    validateOperation = null;
  }

  Future<FormsFieldException?> onValidate(T value);

  Future<void>? cancel() => validateOperation?.cancel();

  void reset() {
    _hasValidate = false;
    _exception = null;
  }
}

class FormsFieldRequiredValidator<T> extends FormsFieldValidator<T> {
  FormsFieldRequiredValidator({required super.triggerTypeList});

  @override
  Future<FormsFieldException?> onValidate(T value) async {
    if (value == null ||
        value == false ||
        value is Iterable && value.isEmpty ||
        value is String && value.isEmpty ||
        value is Map && value.isEmpty) {
      return const FormsFieldRequiredException();
    }

    return null;
  }
}
