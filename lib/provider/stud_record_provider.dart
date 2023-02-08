import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stuentdb_hive/Core/core_widgets.dart';
import 'package:stuentdb_hive/db/functions/db_functions.dart';
import 'package:stuentdb_hive/home/screen/widget/add_student_widget.dart';

class StudentProvider extends ChangeNotifier {
  Future<void> gotoLogin(context) async {
    await Future.delayed(const Duration(seconds: 3));
        Provider.of<DBfunctions>(context, listen: false)
        .getAllStudent();
    
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => AddStudsentWidget()));
  }




  Future<void> deleteStudentButton(int index, context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure want to delete ?'),
            actions: [
              TextButton(
                onPressed: () {
                  
                  Provider.of<DBfunctions>(context, listen: false)
        .deleteStudent(index);
                  Navigator.of(context).pop();
                  snackBar(context, 'Succesfully deleted');
                },
                child: const Text('Yes'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}
