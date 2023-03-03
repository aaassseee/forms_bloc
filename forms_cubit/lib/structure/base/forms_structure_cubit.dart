import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forms_structure_state.dart';

class FormsStructureCubit extends Cubit<FormsStructureState> {
  FormsStructureCubit() : super(FormsStructureInitial());
}
