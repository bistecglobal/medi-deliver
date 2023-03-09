// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class MyCamera extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   MyCamera({required this.cameras});

//   @override
//   _MyCameraState createState() => _MyCameraState();
// }

// class _MyCameraState extends State<MyCamera> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   late String _imagePath;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(
//       widget.cameras[0],
//       ResolutionPreset.high,
//     );

//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _takePicture() async {
//     try {
//       await _initializeControllerFuture;

//       var path = join(
//         (await getTemporaryDirectory()).path,
//         '${DateTime.now()}.png',
//       );

//       await _controller.takePicture();

//       setState(() {
//         _imagePath = path;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Camera Example'),
//       ),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller);
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _takePicture,
//         tooltip: 'Take Picture',
//         child: Icon(Icons.camera_alt),
//       ),
//     );
//   }
// }
