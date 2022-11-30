import 'package:flutter/material.dart';
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
        title: const Text('Edit student'),
        actions: const [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              textformfield('Full name', TextInputType.name, nameController),
              space(),
              textformfield('age', TextInputType.number, ageController),
              space(),
              textformfield(
                  'email', TextInputType.emailAddress, emailController),
              space(),
              textformfield('phone', TextInputType.number, phoneController),
              space(),
              updateButton('Update'),
            ],
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
        onPressed: () {
          submitButton();
        },
        child: Text(text));
  }

  Future<void> submitButton() async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final image = widget.data.image;
    final student = StudentModel(
        name: name, age: age, email: email, phone: phone, image: image);
    if (name.isEmpty || age.isEmpty || phone.isEmpty) {
      return;
    }
    print('$name, $age, $email, $phone');
    updateStudent(student, widget.index!);
    Navigator.of(context).pop();
    snackBar(context);
  }

  Future<void> snackBar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Succesfully Updated'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
    ));
  }
}
