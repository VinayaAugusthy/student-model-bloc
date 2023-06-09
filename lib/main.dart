import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_sample/bloc/addStudentScreen/bloc/add_image_bloc.dart';
import 'package:hive_sample/bloc/home/home_bloc.dart';
import 'package:hive_sample/bloc/search/bloc/search_bloc.dart';
import 'package:hive_sample/bloc/update_image/bloc/update_image_bloc.dart';
import 'package:hive_sample/db/models/data_model.dart';

import 'presentation/Screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  await Hive.openBox<StudentModel>('student_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => AddImageBloc()),
        BlocProvider(create: (context) => UpdateImageBloc()),
        BlocProvider(create: (context) => SearchBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: const HomeScreen(),
      ),
    );
  }
}
