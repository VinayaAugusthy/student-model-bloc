import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_sample/db/models/data_model.dart';

ValueNotifier<List<StudentModel>>studentListNotifier = ValueNotifier([]);


Future<void> addStudents(StudentModel value) async{
  //studentListNotifier.value.add(value);

  final studentDB = await Hive.openBox<StudentModel>('student_db');
 final _id = await studentDB.add(value);
 value.id=_id;
 getAllStudents();
//studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async{
   final studentDB = await Hive.openBox<StudentModel>('student_db');
   studentListNotifier.value.clear();
  // for (var student in studentDB.values) {
  //   studentListNotifier.value.add(student);
  // }
   studentListNotifier.value.addAll(studentDB.values);
   studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async{
   final studentDB = await Hive.openBox<StudentModel>('student_db');
   await studentDB.deleteAt(id);
  getAllStudents();
}

Future<void> updateStudent(int id,StudentModel value) async{
   final studentDB = await Hive.openBox<StudentModel>('student_db');
   studentListNotifier.value.clear();
   await studentDB.putAt(id,value);
  getAllStudents();
}