import 'package:forms_cubit/field/base/forms_field_cubit.dart';

class DropdownFormsFieldCubit<T> extends SingleSelectionFormsFieldCubit<T> {
  DropdownFormsFieldCubit({
    required super.initialValue,
    required super.itemList,
  });
}
