import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/db/model/data_model.dart';
import 'package:stuentdb_hive/home/screen/home_screen.dart';
import 'package:stuentdb_hive/home/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const Dbapp());
}

class Dbapp extends StatelessWidget {
  const Dbapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: coffeeColor),
      home: const SplashScreen(),
    );
  }
}
