import 'package:bloc/bloc.dart';
import 'package:hive_sample/db/models/data_model.dart';
import 'package:meta/meta.dart';

import '../../db/functions/db_functions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(studentList: listStudents)) {
    on<AddStudents>((event, emit) {
      listStudents.add(event.list);
      return emit(HomeState(studentList: listStudents));
    });
    on<DeleteStudents>((event, emit) {
      listStudents.removeAt(event.stdId);
      return emit(HomeState(studentList: listStudents));
    });
    on<UpdateStudents>((event, emit) {
      listStudents.removeAt(event.stdId);
      // listStudents.add(event.newList);
      listStudents.insert(event.stdId, event.newList);
      // listStudents.ad(event.stdId);
    });
  }
}
