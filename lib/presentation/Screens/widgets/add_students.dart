import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_sample/db/functions/db_functions.dart';
import 'package:hive_sample/db/models/data_model.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phnNoController = TextEditingController();
  String? imagepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Student'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Stack(children: [
                  CircleAvatar(
                    backgroundImage: imagepath == null
                        ? const AssetImage('assets/images/dp.jpg')
                            as ImageProvider
                        : FileImage(File(imagepath!)),
                    radius: 75,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      child: const Icon(
                        Icons.add_a_photo_sharp,
                        size: 30,
                      ),
                      onTap: () {
                        takePhoto();
                      },
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.orange),
                          borderRadius: BorderRadius.circular(17.0),
                        ),
                        hintText: 'name..'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3),
                          borderRadius: BorderRadius.circular(17.0),
                        ),
                        hintText: 'age...'),
                    maxLength: 2,
                    buildCounter: (BuildContext context,
                            {required int currentLength,
                            int? maxLength,
                            bool? isFocused}) =>
                        null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: _phnNoController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.orange),
                          borderRadius: BorderRadius.circular(17.0),
                        ),
                        hintText: 'phone number...'),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    buildCounter: (BuildContext context,
                            {required int currentLength,
                            int? maxLength,
                            bool? isFocused}) =>
                        null,
                  ),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      addStudentButtonClicked();
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Add'))
              ],
            ),
          ),
        ));
  }

  Future<void> addStudentButtonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _phnNo = _phnNoController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _phnNo.isEmpty) {
      showSnackBar();
    }
//print('$_name $_age');
    else {
      final _student = StudentModel(
          name: _name, age: _age, phnNo: _phnNo, image: imagepath!);
      addStudents(_student);
      Navigator.of(context).pop();
      studentAddSnackBar();
    }
  }

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagepath = pickedFile.path;
      });
    }
  }

  showSnackBar() {
    var _errMsg = "";

    if (imagepath == null &&
        _nameController.text.isEmpty &&
        _ageController.text.isEmpty &&
        _phnNoController.text.isEmpty) {
      _errMsg = "Please Insert Valid Data In All Fields ";
    } else if (imagepath == null) {
      _errMsg = "Please Select An Image to Continue";
    } else if (_nameController.text.isEmpty) {
      _errMsg = "Name  Must Be Filled";
    } else if (_ageController.text.isEmpty) {
      _errMsg = "Age  Must Be Filled";
    } else if (_phnNoController.text.isEmpty) {
      _errMsg = "Phone Number Must Be Filled";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(_errMsg),
      ),
    );
  }

  void studentAddSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromRGBO(119, 153, 174, 1),
        content: Text('Student is succesfully added!'),
      ),
    );
  }
}
