import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:medi_care_appliaction/details.dart';
import 'package:medi_care_appliaction/takePicture.dart';
import 'dart:async';

import 'package:medi_care_appliaction/trackOrder.dart';
import 'package:medi_care_appliaction/userLogin.dart';

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
                builder: (_) => LoginPage(
                      title: 'Denidu',
                    ));
          } else if (settings.name == '/questions') {
            return MaterialPageRoute(builder: (_) => const Questions());
            // } else if (settings.name == '/booking') {
            //   return MaterialPageRoute(builder: (_) => const Booking());
          } else if (settings.name == '/trakOrder') {
            return MaterialPageRoute(builder: (_) => const TrackOrderPage());
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
