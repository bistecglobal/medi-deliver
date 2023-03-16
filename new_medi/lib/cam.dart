import 'package:camera/camera.dart';

import 'package:flutter/material.dart';

class Cam extends StatefulWidget {
  var cameras;

  Cam(this.cameras, {super.key});

  @override
  State<Cam> createState() => _CamState(cameras);
}

class _CamState extends State<Cam> {
  _CamState(this.cameras);
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  int direction = 0;
  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  Future startCamera(int direction) async {
    // cameras = await availableCameras();

    cameraController = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: () {
                setState(() {
                  direction = direction == 0 ? 1 : 0;
                  startCamera(direction);
                });
              },
              child: button(
                  Icons.flip_camera_android_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () {
                cameraController.takePicture().then((XFile? file) {
                  if (mounted) {
                    if (file != null) {
                      print("picture saved to ${file.path}");
                    }
                  }
                });
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomRight),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 10,
              )
            ]),
        child: const Center(
          child: Icon(
            Icons.flip_camera_ios_outlined,
            color: Colors.amberAccent,
          ),
        ),
      ),
    );
  }
}
