import 'package:flutter/material.dart';
import 'package:stuentdb_hive/Core/strings.dart';
import 'package:stuentdb_hive/db/functions/db_functions.dart';
import 'package:stuentdb_hive/home/screen/widget/add_student_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        title: const Text(addStudentText),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children:  [AddStudsentWidget()],
        ),
      ),
    );
  }
}
