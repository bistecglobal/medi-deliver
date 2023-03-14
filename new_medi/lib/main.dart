import 'package:flutter/material.dart';
import 'package:new_medi/calander.dart';
import 'package:new_medi/cam.dart';

import 'Upload.dart';
import 'dashbord.dart';
import 'login.dart';
import 'questions.dart';
import 'trakOrder.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(
                builder: (_) => const MyLoginPage(
                      title: 'chathura',
                    ));
          } else if (settings.name == '/dashboard') {
            return MaterialPageRoute(builder: (_) => const DashBoard());
          } else if (settings.name == '/upload') {
            return MaterialPageRoute(builder: (_) => const Upload());
          } else if (settings.name == '/questions') {
            return MaterialPageRoute(builder: (_) => const Questions());
          } else if (settings.name == '/booking') {
            return MaterialPageRoute(builder: (_) => const Booking());
          } else if (settings.name == '/trakOrder') {
            return MaterialPageRoute(builder: (_) => const TrakOrder());
          } else if (settings.name == '/cam') {
            return MaterialPageRoute(builder: (_) => const Cam());
          } else {
            return null;
          }
        },
      ),
    );
  }
}
