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

class FormsSelectionFieldNotInItemListException extends FormsFieldException {
  const FormsSelectionFieldNotInItemListException();

  @override
  List<Object?> get props => [];
}
