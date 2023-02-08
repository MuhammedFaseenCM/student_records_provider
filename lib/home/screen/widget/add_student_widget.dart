import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/Core/strings.dart';
import 'package:stuentdb_hive/db/functions/db_functions.dart';
import 'package:stuentdb_hive/db/model/data_model.dart';
import 'package:stuentdb_hive/profile/widgets/list_student_widget.dart';
import 'package:stuentdb_hive/Core/image_widget.dart';
import 'package:stuentdb_hive/provider/add_stud_provider.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class AddStudsentWidget extends StatelessWidget {
  AddStudsentWidget({super.key});

  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addProvider = Provider.of<AddStudProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addPro.picture = '';
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(addStudentText),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              key: scaffoldKey,
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: addPro.formKey,
                child: Consumer<AddStudProvider>(
                  builder: (context, value, child) => Column(
                    children: [
                      space(),
                      value.picture == ''
                          ? imageFun(
                              context: context,
                              image: '',
                              imageFun: addProvider,
                              camIcon: false)
                          : imageFun(
                              context: context,
                              image: value.picture,
                              imageFun: addProvider,
                              camIcon: false),
                      Text(
                        value.imageValid,
                        style: const TextStyle(color: redColor),
                      ),
                      space(),
                      textformfield(
                          fullNameText, TextInputType.name, nameController),
                      space(),
                      textformfield(
                          ageText, TextInputType.number, ageController),
                      space(),
                      textformfield(mailText, TextInputType.emailAddress,
                          emailController),
                      space(),
                      textformfield(
                          numberText, TextInputType.number, phoneController),
                      space(),
                      addbutton(submitText, value.picture),
                      space(),
                      listbutton()
                    ],
                  ),
                ),
              ),
            ),
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

  Widget addbutton(text, validpic) {
    return ElevatedButton(
        onPressed: () {
          if (validpic == '') {
            Provider.of<AddStudProvider>(scaffoldKey.currentContext!,
                    listen: false)
                .changeimageValidString('Select your image');
          } else {
            Provider.of<AddStudProvider>(scaffoldKey.currentContext!,
                    listen: false)
                .changeimageValidString('');
          }
          if (addPro.formKey.currentState!.validate()) {
            submitButton(validpic);
          }
        },
        child: Text(text));
  }

  Widget listbutton() {
    return ElevatedButton(
        onPressed: () {
          scaffoldKey.currentContext!
              .read<AddStudProvider>()
              .changeimageValidString('');

          Provider.of<AddStudProvider>(scaffoldKey.currentContext!,
                  listen: false)
              .resetFormKey();
          Navigator.of(scaffoldKey.currentContext!).push(MaterialPageRoute(
            builder: (context) => const ListRecordStudent(),
          ));
        },
        child: const Text(viewStudText));
  }

  Future<void> submitButton(pic) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final student = StudentModel(
        name: name, age: age, email: email, phone: phone, image: pic);
    if (name.isEmpty ||
        age.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        pic == '') {
      return;
    }
    log('$name, $age, $email, $phone, $picture ');
    Provider.of<DBfunctions>(scaffoldKey.currentContext!, listen: false)
        .addStudent(student);
    addPro.formKey.currentState?.reset();
    Provider.of<AddStudProvider>(scaffoldKey.currentContext!, listen: false)
        .changePictureString('');
    Provider.of<AddStudProvider>(scaffoldKey.currentContext!, listen: false)
        .changeimageValidString('');
    snackBar(scaffoldKey.currentContext!, addedText);
  }
}
