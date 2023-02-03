import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/Core/strings.dart';
import 'package:stuentdb_hive/db/functions/db_functions.dart';
import 'package:stuentdb_hive/db/model/data_model.dart';
import 'package:stuentdb_hive/home/screen/widget/list_student_widget.dart';
import 'package:stuentdb_hive/profile/widgets/image_widget.dart';

class AddStudsentWidget extends StatefulWidget {
  const AddStudsentWidget({super.key});

  @override
  State<AddStudsentWidget> createState() => _AddStudsentWidgetState();
}

class _AddStudsentWidgetState extends State<AddStudsentWidget> {
  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            space(),
            image(image: picture, context: context, setState: setState),
            Text(
              imagevalid,
              style: const TextStyle(color: redColor),
            ),
            space(),
            textformfield(fullNameText, TextInputType.name, nameController),
            space(),
            textformfield(ageText, TextInputType.number, ageController),
            space(),
            textformfield(
                mailText, TextInputType.emailAddress, emailController),
            space(),
            textformfield(numberText, TextInputType.number, phoneController),
            space(),
            addbutton(submitText),
            space(),
            listbutton()
          ],
        ),
      ),
    );
  }

  Widget textformfield(String hinttext, textInputType, controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(), hintText: hinttext),
      keyboardType: textInputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your $hinttext';
        } else {
          return null;
        }
      },
    );
  }

  Widget space() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget addbutton(text) {
    return ElevatedButton(
        onPressed: () {
          if (picture == '') {
            setState(() {
              imagevalid = 'select your image';
            });
          }
          if (formKey.currentState!.validate()) {
            submitButton();
          }
        },
        child: Text(text));
  }

  Widget listbutton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            imagevalid = '';
            formKey.currentState!.reset();
          });

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ListRecordStudent(),
          ));
        },
        child: const Text(viewStudText));
  }

  Future<void> submitButton() async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final student = StudentModel(
        name: name, age: age, email: email, phone: phone, image: picture);
    if (name.isEmpty ||
        age.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        picture == '') {
      return;
    }
    log('$name, $age, $email, $phone, $picture ');
    addStudent(student);
    formKey.currentState?.reset();
    snackBar(context, addedText);
  }
}
