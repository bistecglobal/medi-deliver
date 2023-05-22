import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';

final cameraProvider = Provider<CameraController>((ref) {
  final cameras = availableCameras();
  final camera = cameras[0];
  return CameraController(camera, ResolutionPreset.medium, enableAudio: false);
});

final pictureCaptureProvider = Provider.autoDispose<PictureCaptureBloc>((ref) {
  final cameraController = ref.watch(cameraProvider);
  return PictureCaptureBloc(cameraController);
});

class TakePictureScreen extends ConsumerWidget {
  const TakePictureScreen(firstCamera, {Key? key, required camera})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraController = ref.watch(cameraProvider);
    final bloc = ref.watch(pictureCaptureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Picture'),
      ),
      body: FutureBuilder<void>(
          future: cameraController.initialize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(cameraController);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.capturePicture(context),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class PictureCaptureBloc {
  final CameraController cameraController;

  PictureCaptureBloc(this.cameraController);

  Future<void> dispose() async {
    await cameraController.dispose();
  }

  Future<void> capturePicture(BuildContext context) async {
    try {
      await cameraController.initialize();
      final XFile image = await cameraController.takePicture();
      if (image != null) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(imagePath: image.path),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display the picture'),
      ),
      body: Image.file(File(imagePath)),
    );
  }
}
