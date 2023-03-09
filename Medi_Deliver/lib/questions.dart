import 'package:flutter/material.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bistec care"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(5)),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "Let us know more about you",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: " Your name",
              ),
            ),
            color: Color.fromARGB(255, 232, 243, 249),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: " Phone",
              ),
            ),
            color: Color.fromARGB(255, 229, 244, 248),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: " Email",
              ),
            ),
            color: Color.fromARGB(255, 213, 236, 241),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: " Address",
              ),
            ),
            color: Color.fromARGB(255, 214, 230, 241),
          ),
        ],
      ),
    );
  }
}
