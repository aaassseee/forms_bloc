import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../field/base/forms_field_cubit.dart';

part 'forms_form_state.dart';

abstract class FormsForm {
  Iterable<FormsFieldCubitBase> get fieldCubitList =>
      List.unmodifiable(_fieldCubitList);

  final List<FormsFieldCubitBase> _fieldCubitList = [];

  void addFieldCubit(FormsFieldCubitBase fieldCubit) {
    _fieldCubitList.add(fieldCubit);
  }

  void addAllFieldCubit(Iterable<FormsFieldCubitBase> fieldCubitList) {
    _fieldCubitList.addAll(fieldCubitList);
  }

  void removeFieldCubit(FormsFieldCubitBase fieldCubit) {
    _fieldCubitList.remove(fieldCubit);
  }

  void removeAllFieldCubit(Iterable<FormsFieldCubitBase> fieldCubitList) {
    for (final fieldCubit in fieldCubitList) {
      _fieldCubitList.remove(fieldCubit);
    }
  }

  void insertFieldCubit(int index, FormsFieldCubitBase fieldCubit) {
    _fieldCubitList.insert(index, fieldCubit);
  }

  void insertAllFieldCubit(
      int index, Iterable<FormsFieldCubitBase> fieldCubitList) {
    _fieldCubitList.insertAll(index, fieldCubitList);
  }
}

abstract class FormsFormCubit extends Cubit<FormsFormState> with FormsForm {
  FormsFormCubit() : super(FormInitial());
}
