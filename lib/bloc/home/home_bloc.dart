import 'package:bloc/bloc.dart';
import 'package:hive_sample/db/models/data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<AddStudents>((event, emit) {
      // TODO: implement event handler
      return emit(HomeState(studentList: state.studentList));
    });
  }
}
