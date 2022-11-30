import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stuentdb_hive/db/functions/db_functions.dart';
import 'package:stuentdb_hive/home/screen/widget/search_student_widget.dart';
import 'package:stuentdb_hive/profile/widgets/edit_student_widget.dart';

import '../../../db/model/data_model.dart';
import '../../../profile/widgets/view_student_wigdet.dart';

class List_Student_Widget extends StatefulWidget {
  const List_Student_Widget({super.key});

  @override
  State<List_Student_Widget> createState() => _List_Student_WidgetState();
}

class _List_Student_WidgetState extends State<List_Student_Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student list'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: ValueListenableBuilder(
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                return ListTile(
                  title: Text(data.name),
                  // subtitle: Text('${data.age}\n${data.email}'),
                  leading: CircleAvatar(
                    backgroundImage:
                        MemoryImage(const Base64Decoder().convert(data.image)),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      deleteStudentButton(index);
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ListStudentWidget(data: data, index: index)));
                  },
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: studentList.length);
        },
        valueListenable: studentListNotifier,
      ),
    );
  }

  Future<void> deleteStudentButton(int index) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure want to delete ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteStudent(index);
                    Navigator.of(context).pop();
                    snackBar(context);
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  Future<void> snackBar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Succesfully deleted'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
    ));
  }
}
