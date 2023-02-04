import 'package:flutter/material.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/Core/strings.dart';
import 'package:stuentdb_hive/profile/widgets/image_widget.dart';
import '../../db/functions/db_functions.dart';
import '../../db/model/data_model.dart';

class EditStudentWidget extends StatefulWidget {
  final StudentModel data;

  final int? index;
  const EditStudentWidget({super.key, required this.data, required this.index});

  @override
  State<EditStudentWidget> createState() => _EditStudentWidgetState();
}

class _EditStudentWidgetState extends State<EditStudentWidget> {
  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.data.name.toString();
    ageController.text = widget.data.age.toString();
    emailController.text = widget.data.email.toString();
    phoneController.text = widget.data.phone.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text(editStudText),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              picture = '';
              nochangeText = '';
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                space(),
                imageFun(
               //     image: widget.data.image,
                    context: context),
                space(),
                textformfield(fullNameText, TextInputType.name, nameController),
                space(),
                textformfield(ageText, TextInputType.number, ageController),
                space(),
                textformfield(
                    mailText, TextInputType.emailAddress, emailController),
                space(),
                textformfield(
                    numberText, TextInputType.number, phoneController),
                space(),
                Text(
                  nochangeText,
                  style: const TextStyle(color: redColor),
                ),
                updateButton(submitText),
              ],
            ),
          ),
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
    );
  }

  Widget space() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget updateButton(text) {
    return ElevatedButton(
        onPressed: () async {
          await submitButton();
          // setState(() {
          //   picture = '';
          // });
        },
        child: Text(text));
  }

  Future<void> submitButton() async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final image = picture;
    final student = StudentModel(
        name: name, age: age, email: email, phone: phone, image: image);
    if (name == widget.data.name ||
        age == widget.data.age ||
        phone == widget.data.phone ||
        email == widget.data.email ||
        image == widget.data.image) {
      setState(() {
        nochangeText = 'No changes found';
      });
      return;
    }

    print('$name, $age, $email, $phone');
    updateStudent(student, widget.index!);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    snackBar(context, updateText);
  }
}
