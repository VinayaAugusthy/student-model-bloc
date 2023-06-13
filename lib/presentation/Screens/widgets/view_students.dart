import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_sample/bloc/home/home_bloc.dart';
import 'package:hive_sample/presentation/Screens/widgets/add_students.dart';
import 'package:hive_sample/presentation/Screens/widgets/details.dart';
import 'package:hive_sample/presentation/Screens/widgets/search_student.dart';
import 'package:hive_sample/presentation/Screens/widgets/update_student.dart';
import '../../../db/functions/db_functions.dart';

// ignore: must_be_immutable
class ViewStudent extends StatelessWidget {
  ViewStudent({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    getAllStudents();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Student List'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchStudent()));
                  },
                  icon: const Icon(Icons.search)),
            ],
          ),
          body: ListView.separated(
            itemBuilder: (ctx, index) {
              var data = state.studentList[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  // backgroundColor: Colors.green,
                  backgroundImage: FileImage(File(data.image)),
                ),
                title: Text(data.name),
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpdateStudent(index: index, passValue: data),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.blue),
                    IconButton(
                      onPressed: () {
                        deleteAlert(context, index);
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => Details(
                        passId: index,
                        passValue: data,
                      ),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: state.studentList.length,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStudent()));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  deleteAlert(BuildContext context, key) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text('Delete data Permanently?'),
        actions: [
          TextButton(
              onPressed: () {
                deleteStudent(key, context);
                Navigator.of(context).pop(ctx);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(ctx);
              },
              child: const Text('Cancel'))
        ],
      ),
    );
  }
}
