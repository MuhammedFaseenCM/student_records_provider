import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/Core/strings.dart';
import 'package:stuentdb_hive/Core/image_widget.dart';
import 'package:stuentdb_hive/provider/add_stud_provider.dart';
import '../../db/functions/db_functions.dart';
import '../../db/model/data_model.dart';

class EditStudentWidget extends StatelessWidget {
  final StudentModel data;
  final int? index;
  const EditStudentWidget({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    final addProvider = Provider.of<AddStudProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addProvider.readonly = true;
      addProvider.nochangeText = '';
      addProvider.changeTitle('Student details');
      nameController.text = data.name;
      ageController.text = data.age;
      emailController.text = data.email;
      phoneController.text = data.phone;
    });
    log("=<><>=rebuilded=<><>=");
    return Scaffold(
      appBar: AppBar(
        title: Text(addProvider.studDetails),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              picture = '';
              addProvider.nochangeText = '';
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Consumer<AddStudProvider>(builder: (context, value, _) {
              return Column(
                children: [
                  space(),
                  imageFun(
                      image: value.picture == '' ? data.image : value.picture,
                      context: context,
                      imageFun: addProvider,
                      camIcon: addProvider.readonly),
                  space(),
                  textformfield(
                      fullNameText, TextInputType.name, nameController, value),
                  space(),
                  textformfield(
                      ageText, TextInputType.number, ageController, value),
                  space(),
                  textformfield(mailText, TextInputType.emailAddress,
                      emailController, value),
                  space(),
                  textformfield(
                      numberText, TextInputType.number, phoneController, value),
                  space(),
                  Text(
                    addProvider.nochangeText,
                    style: const TextStyle(color: redColor),
                  ),
                  updateButton(submitText, context, value),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget textformfield(
      String hinttext, textInputType, controller, addProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hinttext),
        space(height: 5.0),
        TextFormField(
          controller: controller,
          readOnly: addProvider.readonly,
          decoration: InputDecoration(
              border: addProvider.readonly ? null : const OutlineInputBorder(),
              hintText: hinttext),
          keyboardType: textInputType,
        ),
      ],
    );
  }

  Widget space({height}) {
    return SizedBox(
      height: height ?? 20,
    );
  }

  Widget updateButton(text, context, addProvider) {
    return addProvider.readonly
        ? ElevatedButton(
            onPressed: () async {
              addProvider.changeReadonly(false);
              addProvider.changeTitle('Edit student details');
            },
            child: const Text("Update"))
        : ElevatedButton(
            onPressed: () async {
              await submitButton(context, addProvider);
            },
            child: Text(text));
  }

  Future<void> submitButton(context, addProvider) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    String image = data.image;
    if (addProvider.picture != '') {
      image = addProvider.picture;
    }

    final student = StudentModel(
        name: name, age: age, email: email, phone: phone, image: image);
    if (name == data.name &&
        age == data.age &&
        phone == data.phone &&
        email == data.email &&
        image == data.image &&
        addProvider.picture == '') {
      addProvider.noChangeText();

      return;
    }

    print('$name, $age, $email, $phone');
    Provider.of<DBfunctions>(context, listen: false)
        .updateStudent(student, index!);
    Navigator.of(context).pop();
    snackBar(context, updateText);
  }
}

final nameController = TextEditingController();

final ageController = TextEditingController();

final emailController = TextEditingController();

final phoneController = TextEditingController();
