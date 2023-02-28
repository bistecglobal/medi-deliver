// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:medi_deliver/component/my_button.dart';
import 'package:medi_deliver/component/my_textfield.dart';

void main() {
  runApp(MediDeliver());
}

abstract class MediDeliver extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Column(children: const [
        SizedBox(height: 50),
        Icon(
          Icons.lock,
          size: 100,
        ),
        SizedBox(height: 50),
        Text(
          "Welcome !",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 25),
        MyTextField(
          controller: usernameController,
          hintText: 'Username',
          obscureText: false,
        ),
        SizedBox(height: 10),
        MyTextField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        MyButton(
          onTap: signUserIn,
        ),
        SizedBox(height: 10),
      ]),
    );
  }
}
