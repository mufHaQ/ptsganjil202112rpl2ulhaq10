import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl2ulhaq10/custom_function/simple_auth.dart';

// ignore: camel_case_types
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void setUsernamePassword() {
    username = usernameController.text;
    password = passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(
              top: 120,
              right: 20,
              left: 20,
            ),
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Username',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 40,
                    width: 80,
                    child: TextButton(
                      onPressed: () {
                        setUsernamePassword();
                        simpleAuth(context, username, password);
                      },
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text('Login'),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
