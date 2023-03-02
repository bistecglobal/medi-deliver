import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  const Upload({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Upload your prescription",
          style: TextStyle(
            fontSize: 30.0,
            color: Color.fromARGB(255, 20, 136, 231),
          ),
        ),
      ),
    );
  }
}
