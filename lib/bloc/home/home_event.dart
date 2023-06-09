part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class AddStudents extends HomeEvent{}

class DeleteStudents extends HomeEvent{}

class UpdateStudents extends HomeEvent{}
