import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuentdb_hive/db/model/data_model.dart';

import '../../db/functions/db_functions.dart';

class ImageWidget extends StatefulWidget {
  final StudentModel data;
  final int? index;
  const ImageWidget({super.key, required this.data, required this.index});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [space(), image(), space(), updateButton()],
      )),
    );
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

  Widget updateButton() {
    return ElevatedButton.icon(
      onPressed: () {
        submitButton();
      },
      icon: const Icon(Icons.camera_alt),
      label: const Text('Update image'),
    );
  }

  Future<void> submitButton() async {
    final name = widget.data.name;
    final age = widget.data.age;
    final email = widget.data.email;
    final phone = widget.data.phone;
    final image = _picture;
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

  Widget space() {
    return const SizedBox(
      height: 20,
    );
  }
}
