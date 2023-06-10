import 'package:bloc/bloc.dart';
import 'package:hive_sample/db/models/data_model.dart';
import 'package:meta/meta.dart';

import '../../db/functions/db_functions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(studentList: listStudents)) {
    on<AddStudents>((event, emit) {
      // TODO: implement event handler
      listStudents.add(event.list);
      return emit(HomeState(studentList: listStudents));
    });
  }
}
