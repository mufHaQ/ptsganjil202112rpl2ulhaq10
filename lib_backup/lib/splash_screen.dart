// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl2ulhaq10/pages/home_page.dart';
import 'package:ptsganjil202112rpl2ulhaq10/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/movie_logo_2.png'),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
