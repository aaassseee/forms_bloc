import 'package:equatable/equatable.dart';
import 'package:forms_cubit/forms_cubit.dart';

class MockObject extends Equatable {
  const MockObject(this.mockParameter);

  final Object mockParameter;

  @override
  List<Object?> get props => [mockParameter];
}

class MockFormsFieldCubit extends FormsFieldCubit<MockObject> {
  MockFormsFieldCubit({
    super.initialValue = const MockObject(''),
    super.validation,
  });
}
