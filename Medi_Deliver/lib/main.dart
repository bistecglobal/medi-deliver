// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/calander.dart';

import 'Login.dart';
// import 'package:medi_deliver/camera.dart';
// import 'package:medi_deliver/dashbord.dart';
// import 'package:medi_deliver/login.dart';
// import 'package:medi_deliver/calander.dart';
// import 'Upload.dart';
// import 'fetch.dart';
// import 'questions.dart';

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
      home: MyLoginPage(
        // cameras: [],

        title: 'chathura',
      ),
    );
  }
}
