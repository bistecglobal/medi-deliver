import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dashbord.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  var _userIdController = TextEditingController();
  var _userPassController = TextEditingController();

  void _DashBoard() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return const DashBoard();
      },
    ));
  }

  void _handleSignInButtonPress() {
    print("_userIdController");

    var userId = "abc";
    var password = "abc123";

    if (userId == _userIdController.text &&
        password == _userPassController.text) {
      return _DashBoard();
    }
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
        body: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30.0),
              Text(
                "welcome !",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                "Login in to your account",
                style: TextStyle(
                    color: Color.fromARGB(255, 28, 146, 243), fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                child: TextField(
                  controller: _userIdController,
                  style: TextStyle(fontSize: 20.0),
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "username",
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: TextField(
                  controller: _userPassController,
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forget password",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF2196F3),
                ),
                child: TextButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: _handleSignInButtonPress,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an accountant?"),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sign up here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
