part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class Search extends SearchEvent {
  List<StudentModel> student;
  final String value;
  Search({required this.value, required this.student});
}
