import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/profile/widgets/edit_student_widget.dart';

import '../../../db/functions/db_functions.dart';
import '../../../db/model/data_model.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<DBfunctions>(
      builder: (BuildContext ctx, value, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = DBfunctions.studentList[index];
            if (data.name.toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(ctx).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              EditStudentWidget(data: data, index: data.index),
                        ),
                      );
                    },
                    title: Text(data.name),
                    leading: imageContainer(image: data.image),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: redColor,
                      ),
                      onPressed: () {
                        deleteStudentButton(index, context);
                      },
                    ),
                  ),
                  const Divider()
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: DBfunctions.studentList.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<DBfunctions>(
      builder: (BuildContext ctx, value, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = DBfunctions.studentList[index];
            if (data.name.toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  space(height: 10.0),
                  ListTile(
                    onTap: () {
                      Navigator.of(ctx).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => EditStudentWidget(
                                data: data, index: data.index)),
                      );
                    },
                    title: Text(data.name),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: redColor,
                      ),
                      onPressed: () {
                        deleteStudentButton(index, context);
                      },
                    ),
                    leading: imageContainer(image: data.image),
                  ),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: DBfunctions.studentList.length,
        );
      },
    );
  }
}
