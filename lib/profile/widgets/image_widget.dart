import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/Core/strings.dart';


Widget image({required image, required context, required setState}) {
  return Center(
    child: Stack(children: [
      imageContainer(
          image: picture == '' ? image : picture, height: 100.0, width: 100.0),
      Positioned(
          child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: ((builder) =>
                bottomsheet(context: context, setState: setState)),
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

Widget bottomsheet({required context, required setState}) {
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
                  pickImage(
                      source: ImageSource.gallery,
                      setState: setState,
                      context: context);
                },
                icon: const Icon(Icons.image),
                label: const Text(gallery)),
            TextButton.icon(
                onPressed: () {
                  pickImage(
                      source: ImageSource.camera,
                      setState: setState,
                      context: context);
                },
                icon: const Icon(Icons.camera),
                label: const Text(camera))
          ],
        )
      ],
    ),
  );
}

pickImage({required source, required setState, required context}) async {
  final image = await picker.pickImage(source: source);
  if (image == null) {
    return;
  }

  setState(() {
    picture = image.path;
    Navigator.of(context).pop();
  });
}
