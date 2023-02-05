import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/strings.dart';
import 'package:stuentdb_hive/db/functions/db_functions.dart';
import 'package:stuentdb_hive/home/screen/widget/add_student_widget.dart';
import 'package:stuentdb_hive/provider/add_stud_provider.dart';

final addPro = AddStudProvider();
Future<void> deleteStudentButton(int index, context) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure want to delete ?'),
          actions: [
            TextButton(
                onPressed: () {
                  deleteStudent(index);
                  Navigator.of(context).pop();
                  snackBar(context, 'Succesfully deleted');
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'))
          ],
        );
      });
}

Future<void> snackBar(BuildContext context, text) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: greenColor,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
  ));
}

Widget imageContainer({required image, height, width}) {
  return Container(
      height: height ?? 70,
      width: width ?? 70,
      decoration: addPro.picture != ''
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover, image: FileImage(File(image))))
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    defaultProfText,
                  ))));
}

Widget space() {
  return const SizedBox(
    height: 20,
  );
}

Widget textformfield(controller) {
  return TextFormField(
    controller: controller,
    readOnly: true,
    decoration: const InputDecoration(border: OutlineInputBorder()),
  );
}

Widget imageContainer1({height, width, required pic}) {
  if (addPro.picture == '') {
    return const CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(defaultProfText),
    );
  } else {
    return Consumer<AddStudProvider>(builder: (context, value, child) {
      log(value.value);
      return CircleAvatar(
        radius: 50,
        backgroundImage: FileImage(
          File(
              //  Provider.of<AddStudProvider>(scaffoldKey.currentState!.context)
              value.value),
        ),
      );
    });
  }

  //  Container(
  //     height: height ?? 70,
  //     width: width ?? 70,
  //     decoration:
  //         //addPro.picture != null || addPro.picture != ''
  //         //     ? BoxDecoration(
  //         //         borderRadius: BorderRadius.circular(10),
  //         //         image: DecorationImage(
  //         //             fit: BoxFit.cover, image: FileImage(File(addPro.picture))))
  //         //     :
  //         BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             image: const DecorationImage(
  //                 fit: BoxFit.cover,
  //                 image: NetworkImage(
  //                   defaultProfText,
  //                 ))));
}
