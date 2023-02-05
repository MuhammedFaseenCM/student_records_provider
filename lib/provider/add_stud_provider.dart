import 'package:flutter/material.dart';
import 'package:stuentdb_hive/Core/strings.dart';

class AddStudProvider extends ChangeNotifier {
  String picture = '';
  String imageValid = '';
  final formKey = GlobalKey<FormState>();

  String get value => picture;

  set value(String newValue) {
    picture = newValue;
    notifyListeners();
  }

  void changePictureString(text) {
    picture = text;
    notifyListeners();
  }

  void changeimageValidString(text) {
    imageValid = text;
    notifyListeners();
  }

  void resetFormKey() {
    if (formKey.currentState == null) {
      return;
    }
    formKey.currentState!.reset();
    notifyListeners();
  }

  pickImage({required source, required context}) async {
    final image = await picker.pickImage(source: source);
    if (image == null) {
      return;
    }
    
      picture = image.path;
    

    notifyListeners();
    Navigator.of(context).pop();
  }
}
