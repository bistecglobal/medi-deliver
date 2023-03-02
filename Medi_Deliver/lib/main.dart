import 'package:flutter/material.dart';

void main() {
  runApp(MediDeliver());
}

class MediDeliver extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // username.text="chathura";
    // String name = username.text;
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
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              SizedBox(height: 80.0),
              Text(
                "welcome !",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(height: 20.0),
              Text("Login in to your account"),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(fontSize: 20.0),
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "username",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              Text("forget password"),
              SizedBox(height: 4.0),
              Center(
                child: Text("Sign In"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
