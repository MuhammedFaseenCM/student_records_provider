import 'package:flutter/material.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/Core/strings.dart';
import 'package:stuentdb_hive/db/functions/db_functions.dart';
import 'package:stuentdb_hive/home/screen/widget/search_student_widget.dart';

import '../../../db/model/data_model.dart';
import '../../../profile/widgets/view_student_wigdet.dart';

class ListRecordStudent extends StatefulWidget {
  const ListRecordStudent({super.key});

  @override
  State<ListRecordStudent> createState() => _ListRecordStudentState();
}

class _ListRecordStudentState extends State<ListRecordStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(studListText),
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                return Card(
                  child: ListTile(
                    title: Text(data.name),
                    // subtitle: Text('${data.age}\n${data.email}'),
                    leading: imageContainer(image: data.image),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: redColor
                      ),
                      onPressed: () {
                        deleteStudentButton(index, context);
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ListStudentWidget(data: data, index: index)));
                    },
                  ),
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
}
