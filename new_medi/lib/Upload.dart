// ignore: file_names
import 'package:flutter/material.dart';

import 'calander.dart';

class Upload extends StatefulWidget {
  // const Upload({super.key});
  final String location;
  const Upload({super.key, required this.location});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String place = '';
  @override
  void initState() {
    super.initState();
    place = widget.location;
  }

  void _booking() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Booking(location: place)),
    );
    // Navigator.pushNamed(context, '/booking');
  }

  void _cam() {
    Navigator.pushNamed(context, '/cam');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Upload your prescription",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 136, 231),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 30),
                  child: IconButton(
                    onPressed: _cam,
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 80,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: const EdgeInsets.all(80.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 24, 141, 237),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Upload  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  IconButton(
                    onPressed: _booking,
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
