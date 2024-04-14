import 'package:forms_cubit/forms_cubit.dart';
import 'package:test/test.dart';

void main() {
  test('exception FormsFieldRequiredException', () {
    expect(
        const FormsFieldRequiredException() ==
            const FormsFieldRequiredException(),
        isTrue);
  });

  test('exception FormsSelectionFieldNotInItemListException', () {
    expect(
        const FormsSelectionFieldNotInItemListException() ==
            const FormsSelectionFieldNotInItemListException(),
        isTrue);
  });
}
