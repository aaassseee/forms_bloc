import '../forms_bloc.dart';

class TextFormsFieldCubit extends FormsFieldCubit<String> {
  TextFormsFieldCubit({
    required super.initialValue,
    super.validation,
  });
}
