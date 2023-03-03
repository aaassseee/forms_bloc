import '../forms_cubit.dart';

class TextFormsFieldCubit extends FormsFieldCubit<String> {
  TextFormsFieldCubit({
    required super.initialValue,
    super.validation,
  });
}
