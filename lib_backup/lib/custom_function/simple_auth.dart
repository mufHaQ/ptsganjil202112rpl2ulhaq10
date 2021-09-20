import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ptsganjil202112rpl2ulhaq10/pages/home_page.dart';
import 'package:ptsganjil202112rpl2ulhaq10/custom_function/debug_print.dart';

void simpleAuth(BuildContext context, String username, String password) {
  if (username == 'mufhaq' && password == 'mufhaq') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
    EasyLoading.showToast('Welcome $username',
        toastPosition: EasyLoadingToastPosition.bottom);
    debug_print('Login username: $username');
  } else {
    EasyLoading.showToast(
      'wrong username or password',
      toastPosition: EasyLoadingToastPosition.bottom,
    );
  }
}
