import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dashbord.dart';

class Album {
  // ignore: non_constant_identifier_names
  final String UserName;
  // ignore: non_constant_identifier_names
  final String Password;

  // ignore: non_constant_identifier_names
  const Album({required this.UserName, required this.Password});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      UserName: json['UserName'],
      Password: json['Password'],
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  Future login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://medi.bto.bistecglobal.com/api/Function1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'UserName': username,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      return _DashBoard();
    } else {
      throw Exception('Failed to create album.');
    }
  }

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var futureAlbum;

  // ignore: non_constant_identifier_names
  void _DashBoard() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DashBoard(value: _userIdController.text)),
    );
    // Navigator.pushNamed(context, '/dashboard');
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    _userIdController.dispose();
    _userPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Medi Deliver"),
        ),
        body: ListView(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 470.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 30.0),
                  const Text(
                    "welcome ",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "Log in to your account",
                    style: TextStyle(
                        color: Color.fromARGB(255, 28, 146, 243),
                        fontSize: 15.0),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    child: TextField(
                      controller: _userIdController,
                      style: const TextStyle(fontSize: 20.0),
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "username",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: TextField(
                      controller: _userPassController,
                      obscureText: true,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "Forget password",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 50, right: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xFF2196F3),
                    ),
                    child: TextButton(
                      onPressed: () {
                        login(_userIdController.text, _userPassController.text);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Don't have an account?"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign up here",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
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
