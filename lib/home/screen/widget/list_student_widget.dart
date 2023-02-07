import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/Core/strings.dart';
import 'package:stuentdb_hive/db/functions/db_functions.dart';
import 'package:stuentdb_hive/db/model/data_model.dart';
import 'package:stuentdb_hive/home/screen/widget/search_student_widget.dart';
import 'package:stuentdb_hive/profile/widgets/edit_student_widget.dart';
import 'package:stuentdb_hive/provider/stud_record_provider.dart';

class ListRecordStudent extends StatelessWidget {
  const ListRecordStudent({super.key});

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
                    trailing: Consumer<StudentProvider>(
                      builder: (context, value, child) {
                        return IconButton(
                          icon: const Icon(Icons.delete, color: redColor),
                          onPressed: () {
                            value.deleteStudentButton(index, context);
                          },
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditStudentWidget(data: data, index: index)));
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
