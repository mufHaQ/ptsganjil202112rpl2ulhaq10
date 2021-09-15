import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ptsganjil202112rpl2ulhaq10/splash_screen.dart';

void main() async {
  await dotenv.load();
  runApp(MaterialApp(
    home: const SplashScreen(),
    theme: ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 247, 246, 246),
    ),
    builder: EasyLoading.init(),
  ));
}
