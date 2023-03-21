import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:new_medi/calander.dart';
import 'package:new_medi/takePicture.dart';

import 'Upload.dart';
import 'dashbord.dart';
import 'login.dart';
import 'questions.dart';
import 'trakOrder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyWidget(cameras: firstCamera));
}

class MyWidget extends StatefulWidget {
  final cameras;

  const MyWidget({super.key, this.cameras});

  @override
  State<MyWidget> createState() => _MyWidgetState(cameras: cameras);
}

class _MyWidgetState extends State<MyWidget> {
  final cameras;

  _MyWidgetState({this.cameras});

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
            return MaterialPageRoute(
                builder: (_) => TakePictureScreen(
                      cameras.firstCamera,
                      camera: cameras,
                    ));
          } else {
            return null;
          }
        },
      ),
    );
  }
}
