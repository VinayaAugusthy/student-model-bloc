part of 'home_bloc.dart';

@immutable
 class HomeState {
  final List<StudentModel> studentList;

  const HomeState({required this.studentList});
}

class HomeInitial extends HomeState {
  HomeInitial() :super(studentList: []);
}
