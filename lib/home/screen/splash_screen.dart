import 'package:flutter/material.dart';
import 'package:stuentdb_hive/Core/colors.dart';
import 'package:stuentdb_hive/Core/strings.dart';
import 'package:stuentdb_hive/home/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(2),
          child: Center(
            child: Text(
              studRecordText,
              style: TextStyle(
                color: blueColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const HomeScreen()));
  }
}
