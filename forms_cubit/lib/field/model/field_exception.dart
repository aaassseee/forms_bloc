import 'package:equatable/equatable.dart';

abstract class FormsFieldException extends Equatable implements Exception {
  const FormsFieldException();
}

abstract class FormsFieldValidationException extends FormsFieldException {
  const FormsFieldValidationException();
}

class FormsFieldRequiredException extends FormsFieldValidationException {
  const FormsFieldRequiredException();

  @override
  List<Object?> get props => [];
}

abstract class FormsFieldStateException extends FormsFieldException {
  const FormsFieldStateException();
}

class FormsFieldValidatingException extends FormsFieldStateException {
  const FormsFieldValidatingException();

  @override
  List<Object?> get props => [];
}
