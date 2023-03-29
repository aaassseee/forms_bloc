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

  FutureOr<void> validate(T value) async {
    reset();
    _exception = await onValidate(value);
    _hasValidate = true;
  }

  FutureOr<FormsFieldException?> onValidate(T value);

  void reset() {
    _hasValidate = false;
    _exception = null;
  }
}

class FormsFieldRequiredValidator<T> extends FormsFieldValidator<T> {
  FormsFieldRequiredValidator({required super.triggerTypeList});

  @override
  FutureOr<FormsFieldException?> onValidate(T value) {
    if (value == null ||
        value == false ||
        value is Iterable && value.isEmpty ||
        value is String && value.isEmpty ||
        value is Map && value.isEmpty) {
      return FormsFieldRequiredException();
    }

    return null;
  }
}
