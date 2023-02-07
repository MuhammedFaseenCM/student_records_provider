import 'package:flutter/material.dart';
import 'package:stuentdb_hive/Core/strings.dart';

class AddStudProvider extends ChangeNotifier {
  String picture = '';
  String imageValid = '';
  bool readonly = true;
  String nochangeText = '';
  final formKey = GlobalKey<FormState>();
  String studDetails = 'Student details';

  String get value => picture;

  set value(String newValue) {
    picture = newValue;
    notifyListeners();
  }

  void changePictureString(text) {
    picture = text;
    notifyListeners();
  }

  void noChangeText() {
    nochangeText = 'No changes found';
    notifyListeners();
  }

  void changeTitle(text) {
    studDetails = text;
    notifyListeners();
  }

  void changeReadonly(value) {
    readonly = value;
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
