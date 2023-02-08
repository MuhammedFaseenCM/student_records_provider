import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/db/functions/db_functions.dart';
import 'package:stuentdb_hive/db/model/data_model.dart';
import 'package:stuentdb_hive/home/screen/splash_screen.dart';
import 'package:stuentdb_hive/provider/add_stud_provider.dart';
import 'package:stuentdb_hive/provider/stud_record_provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider()),
        ChangeNotifierProvider(create: (context) => AddStudProvider()),
        ChangeNotifierProvider(create: (context) => DBfunctions())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: coffeeColor),
        home: const SplashScreen(),
      ),
    );
  }
}
