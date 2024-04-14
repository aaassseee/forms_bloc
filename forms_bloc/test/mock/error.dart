import 'package:forms_bloc/field/model/field_exception.dart';
import 'package:mockito/mockito.dart';

class FakeFormsFieldValidationException extends Fake
    implements FormsFieldValidationException {
  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FakeFormsFieldValidationException &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
