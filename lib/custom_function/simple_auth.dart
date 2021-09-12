// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl2ulhaq10/pages/home_page.dart';
import 'package:ptsganjil202112rpl2ulhaq10/custom_function/debug_print.dart';

void simpleAuth(BuildContext context, String username, String password) {
  if (username == 'mufhaq' && password == 'mufhaq') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
    debug_print('Login username: $username');
  }
}
