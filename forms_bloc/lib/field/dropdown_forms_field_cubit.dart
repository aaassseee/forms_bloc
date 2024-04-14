import 'package:forms_bloc/field/base/forms_field_cubit.dart';

class DropdownFormsFieldCubit<T> extends FormsSingleSelectionFieldCubit<T> {
  DropdownFormsFieldCubit({
    required super.initialValue,
    required super.itemList,
    super.validation,
  });
}
