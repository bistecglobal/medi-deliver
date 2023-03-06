import 'package:flutter/material.dart';
import 'package:medi_deliver/dashbord.dart';
import 'package:medi_deliver/login.dart';
import 'Upload.dart';

void main() {
  runApp(MediDeliver());
}

class MediDeliver extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const MyLoginPage(title: "Medi Deliver"),
      home: const MyLoginPage(
          title: 'chathura',
          ),
      // routes: <String,WvidgetBuilder>{
      //   '/login':(context) => const Login();
      // },
    );
  }
}
