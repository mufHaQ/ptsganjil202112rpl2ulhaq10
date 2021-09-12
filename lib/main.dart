import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl2ulhaq10/splash_screen.dart';

void main() async {
  await dotenv.load();
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
}
