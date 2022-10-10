import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'forms_field_cubit.dart';

part 'forms_form_state.dart';

abstract class FormsForm {
  Iterable<FormsFieldCubit> get fieldCubitList =>
      List.unmodifiable(_fieldCubitList);

  final List<FormsFieldCubit> _fieldCubitList = [];

  void addFieldCubit(FormsFieldCubit fieldCubit) {
    _fieldCubitList.add(fieldCubit);
  }

  void addAllFieldCubit(Iterable<FormsFieldCubit> fieldCubitList) {
    _fieldCubitList.addAll(fieldCubitList);
  }

  void removeFieldCubit(FormsFieldCubit fieldCubit) {
    _fieldCubitList.remove(fieldCubit);
  }

  void removeAllFieldCubit(Iterable<FormsFieldCubit> fieldCubitList) {
    for (final fieldCubit in fieldCubitList) {
      _fieldCubitList.remove(fieldCubit);
    }
  }

  void insertFieldCubit(int index, FormsFieldCubit fieldCubit) {
    _fieldCubitList.insert(index, fieldCubit);
  }

  void insertAllFieldCubit(
      int index, Iterable<FormsFieldCubit> fieldCubitList) {
    _fieldCubitList.insertAll(index, fieldCubitList);
  }
}

abstract class FormsFormCubit extends Cubit<FormsFormState> with FormsForm {
  FormsFormCubit() : super(FormInitial());
}
