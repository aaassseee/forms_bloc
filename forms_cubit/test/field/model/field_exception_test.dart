import 'package:forms_cubit/forms_cubit.dart';
import 'package:test/test.dart';

void main() {
  test('exception FormsFieldRequiredException', () {
    expect(
        FormsFieldRequiredException() == FormsFieldRequiredException(), isTrue);
  });

  test('exception FormsSelectionFieldNotInItemListException', () {
    expect(
        FormsSelectionFieldNotInItemListException() ==
            FormsSelectionFieldNotInItemListException(),
        isTrue);
  });
}
