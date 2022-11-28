import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stuentdb_hive/profile/widgets/edit_student_widget.dart';

import '../../db/model/data_model.dart';
import 'edit_image_widget.dart';

class ListStudentWidget extends StatefulWidget {
  StudentModel data;

  int? index;
  ListStudentWidget({super.key, required this.data, required this.index});

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
    nameController.text = 'Name : ${widget.data.name}';
    ageController.text = 'Age : ${widget.data.age}';
    emailController.text = 'Email : ${widget.data.email}';
    phoneController.text = 'Phone number : ${widget.data.phone}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student details'),
        actions: const [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              space(),
              ImageProfile(),
              space(),
              textformfield(nameController),
              space(),
              textformfield(ageController),
              space(),
              textformfield(emailController),
              space(),
              textformfield(phoneController),
              space(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [updateButton(), imageButton()],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textformfield(controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: const InputDecoration(border: InputBorder.none),
    );
  }

  Widget space() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget updateButton() {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return EditStudentWidget(data: widget.data, index: widget.index);
          }));
        },
        icon: const Icon(Icons.edit),
        label: const Text('Edit details'));
  }

  Widget imageButton() {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return ImageWidget(data: widget.data, index: widget.index);
          }));
        },
        icon: const Icon(Icons.camera_alt),
        label: const Text('Edit image'));
  }

  Widget ImageProfile() {
    return Center(
      child: CircleAvatar(
        backgroundImage:
            MemoryImage(const Base64Decoder().convert(widget.data.image)),
        radius: 50,
      ),
    );
  }
}
