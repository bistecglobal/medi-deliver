import 'package:flutter/material.dart';
import 'package:medi_deliver/component/my_textfield.dart';

void main() {
  runApp(MediDeliver());
}

class MediDeliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Column(children: const [
        SizedBox(height: 50),
        Icon(
          Icons.lock,
          size: 100,
        ),
        SizedBox(height: 50),
        Text(
          "Welcome !",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 25),
        MyTextField(),
        MyTextField(),
      ]),
    );
  }
}
