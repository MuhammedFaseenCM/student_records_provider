import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/Core/strings.dart';

Widget imageFun({ required context}) {
  return Center(
    child: Stack(children: [
      imageContainer1( height: 100.0, width: 100.0),
      Positioned(
          child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: ((builder) => bottomsheet(context: context)),
          );
        },
        child: const Icon(
          Icons.camera_alt,
          size: 30,
          color: whiteColor,
        ),
      ))
    ]),
  );
}

Widget bottomsheet({required context}) {
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      children: <Widget>[
        const Text(
          chooseText,
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
                addPro.pickImage(source: ImageSource.gallery, context: context);
                },
                icon: const Icon(Icons.image),
                label: const Text(gallery)),
            TextButton.icon(
                onPressed: () {
                  addPro.pickImage(source: ImageSource.camera, context: context);
                },
                icon: const Icon(Icons.camera),
                label: const Text(camera))
          ],
        )
      ],
    ),
  );
}


