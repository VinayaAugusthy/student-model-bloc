part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class AddStudents extends HomeEvent {
  final StudentModel list;

  AddStudents({required this.list});
}

class DeleteStudents extends HomeEvent {}

class UpdateStudents extends HomeEvent {}
