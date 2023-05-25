import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TakePictureBloc extends Bloc<void, TakePictureState> {
  final CameraController _controller;

  TakePictureBloc(this._controller) : super(const TakePictureInitial());

  @override
  Stream<TakePictureState> mapEventToState(void event) async* {
    try {
      yield const TakePictureInProgress();
      await _controller.initialize();
      final image = await _controller.takePicture();
      yield TakePictureSuccess(image.path);
    } catch (e) {
      yield TakePictureFailure(e.toString());
    }
  }
}

abstract class TakePictureState {
  const TakePictureState();
}

class TakePictureInitial extends TakePictureState {
  const TakePictureInitial();
}

class TakePictureInProgress extends TakePictureState {
  const TakePictureInProgress();
}

class TakePictureSuccess extends TakePictureState {
  final String imagePath;

  const TakePictureSuccess(this.imagePath);
}

class TakePictureFailure extends TakePictureState {
  final String error;

  const TakePictureFailure(this.error);
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen(
    firstCamera, {
    required Key key,
    required this.camera,
  }) : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late TakePictureBloc _bloc;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _initializeController();
    _bloc = TakePictureBloc(_controller);
  }

  Future<void> _initializeController() async {
    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture'),
      ),
      body: BlocBuilder<TakePictureBloc, TakePictureState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is TakePictureInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TakePictureSuccess) {
            return CameraPreview(_controller);
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bloc.add(null),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
