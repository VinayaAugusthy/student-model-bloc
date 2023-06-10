import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_sample/bloc/home/home_bloc.dart';
import 'package:hive_sample/db/models/data_model.dart';

List<StudentModel> listStudents = [];

addStudents(StudentModel student, BuildContext context) {
  //studentListNotifier.value.add(value);

  final studentDB = Hive.box<StudentModel>('student_db');
  BlocProvider.of<HomeBloc>(context).add(AddStudents(list: student));
  studentDB.add(student);
  // listStudents.id = _id;
  getAllStudents();
}

getAllStudents() {
  final studentDB = Hive.box<StudentModel>('student_db');
  listStudents.clear();
  listStudents.addAll(studentDB.values);
}

deleteStudent(int id, BuildContext context) {
  final studentDB = Hive.box<StudentModel>('student_db');
  BlocProvider.of<HomeBloc>(context).add(DeleteStudents(stdId: id));
  studentDB.deleteAt(id);
  getAllStudents();
}

updateStudent(int id, StudentModel value, BuildContext context) {
  final studentDB = Hive.box<StudentModel>('student_db');
  BlocProvider.of<HomeBloc>(context)
      .add(UpdateStudents(newValue: value, stdId: id));
  studentDB.putAt(id, value);
  getAllStudents();
}
