import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stuentdb_hive/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final id = await studentDB.add(value);
  value.index = id;
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudent() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(index);
  getAllStudent();
}

Future<void> updateStudent(StudentModel value, int index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.putAt(index, value);
  await getAllStudent();
}
