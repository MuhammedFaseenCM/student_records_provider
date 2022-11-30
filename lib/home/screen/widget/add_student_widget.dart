import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuentdb_hive/db/functions/db_functions.dart';
import 'package:stuentdb_hive/db/model/data_model.dart';
import 'package:stuentdb_hive/home/screen/widget/list_student_widget.dart';

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

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            space(),
            image(),
            space(),
            textformfield('Full name', TextInputType.name, nameController),
            space(),
            textformfield('age', TextInputType.number, ageController),
            space(),
            textformfield('Email', TextInputType.emailAddress, emailController),
            space(),
            textformfield(
                'Phone Number', TextInputType.number, phoneController),
            space(),
            addbutton('Submit'),
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
          if (formKey.currentState!.validate()) {
            submitButton();
          }
        },
        child: Text(text));
  }

  Widget listbutton() {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const List_Student_Widget(),
          ));
        },
        child: const Text('View student list'));
  }

  Future<void> submitButton() async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final student = StudentModel(
        name: name,
        age: age,
        email: email,
        phone: phone,
        image: _picturetoString);
    if (name.isEmpty || age.isEmpty || email.isEmpty || phone.isEmpty) {
      return;
    }
    print('$name, $age, $email, $phone, $_picturetoString ');
    addStudent(student);
    formKey.currentState?.reset();
    snackBar(context);
  }

  Future<void> snackBar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Succesfully added'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
    ));
  }

  Widget image() {
    return Center(
      child: Stack(children: [
        CircleAvatar(
          backgroundImage: _picture != null
              ? MemoryImage(const Base64Decoder().convert(_picture))
              : const NetworkImage(
                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                ) as ImageProvider,
          radius: 50,
        ),
        Positioned(
            child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => bottomsheet()),
            );
          },
          child: const Icon(
            Icons.camera_alt,
            size: 30,
          ),
        ))
      ]),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            'Choose your photo',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery')),
              TextButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'))
            ],
          )
        ],
      ),
    );
  }

  String _picture = '';
  String _picturetoString = '';

  pickImage(source) async {
    final image = await _picker.pickImage(source: source);
    if (image == null) {
      return;
    }
    final selectedimage = File(image.path).readAsBytesSync();
    setState(() {
      _picturetoString = base64Encode(selectedimage);
      _picture = _picturetoString;
    });
  }
}
