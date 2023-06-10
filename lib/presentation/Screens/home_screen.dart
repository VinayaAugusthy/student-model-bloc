import 'package:flutter/material.dart';

import 'package:hive_sample/presentation/Screens/widgets/view_students.dart';
import 'package:hive_sample/db/functions/db_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      body: ViewStudent(),
    );
  }
}
