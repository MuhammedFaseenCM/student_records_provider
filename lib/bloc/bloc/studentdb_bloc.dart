import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'studentdb_event.dart';
part 'studentdb_state.dart';

class StudentdbBloc extends Bloc<StudentdbEvent, StudentdbState> {
  StudentdbBloc() : super(StudentdbInitial()) {
    on<StudentdbEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
