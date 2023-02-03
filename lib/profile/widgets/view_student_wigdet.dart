import 'package:flutter/material.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/Core/strings.dart';
import 'package:stuentdb_hive/profile/widgets/edit_student_widget.dart';

import '../../db/model/data_model.dart';

class ListStudentWidget extends StatefulWidget {
  final StudentModel data;

  final int? index;
  const ListStudentWidget({super.key, required this.data, required this.index});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = '$fullNameText : ${widget.data.name}';
    ageController.text = '$ageText: ${widget.data.age}';
    emailController.text = '$mailText : ${widget.data.email}';
    phoneController.text = '$numberText : ${widget.data.phone}';
    return Scaffold(
      appBar: AppBar(
        title: const Text(studDetails),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              space(),
              imageContainer(
                  image: widget.data.image, height: 100.0, width: 100.0),
              space(),
              textformfield(nameController),
              space(),
              textformfield(ageController),
              space(),
              textformfield(emailController),
              space(),
              textformfield(phoneController),
              space(),
              updateButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget updateButton() {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return EditStudentWidget(data: widget.data, index: widget.index);
          }));
        },
        icon: const Icon(Icons.edit),
        label: const Text(editStudText));
  }
}
