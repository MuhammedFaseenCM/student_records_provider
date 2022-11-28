import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  int? index;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String image;
  StudentModel(
      {required this.name,
      required this.age,
      this.index,
      required this.email,
      required this.phone,
      required this.image});
}
