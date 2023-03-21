import 'package:flutter/material.dart';
import 'trakOrder.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Patient {
  final String YourName;
  final String Phone;
  final String Email;
  final String Address;

  const Patient(
      {required this.YourName,
      required this.Phone,
      required this.Email,
      required this.Address});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        YourName: json['YourName'],
        Phone: json['Phone'],
        Email: json['Email'],
        Address: json['Address']);
  }
}

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  final TextEditingController _userNameController =
      TextEditingController(text: null);
  final TextEditingController _userPhoneController =
      TextEditingController(text: null);
  final TextEditingController _userEmailController =
      TextEditingController(text: null);
  final TextEditingController _userAddressController =
      TextEditingController(text: null);

  void _trakOrder() {
    print(_userNameController);
    print(_userPhoneController);
    print(_userEmailController);
    print(_userAddressController);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return const TrakOrder();
      },
    ));
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    _userAddressController.dispose();
    _userEmailController.dispose();
    _userNameController.dispose();
    _userPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _TrakOrder() {
      Navigator.pushNamed(context, '/trakOrder');
    }

    Future<Patient> _savePatient(
        String YourName, String Phone, String Email, String Address) async {
      final response = await http.post(
        Uri.parse('https://medi.bto.bistecglobal.com/api/SavePatient'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'YourName': YourName,
          'Phone': Phone,
          'Email': Email,
          'Address': Address,
        }),
      );

      if (response.statusCode == 200) {
        print("hi hi it's working");
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/trakOrder');
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        return Patient.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create album.');
      }
    }

    var userNameController = "hello";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bistec care"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(padding: EdgeInsets.all(5)),
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
          child: const Text(
            "Let us know more about you",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 20, right: 30, bottom: 5),
          color: const Color.fromARGB(255, 250, 250, 250),
          child: TextFormField(
            controller: _userNameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter your name",
              hintStyle: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 1, left: 20, right: 30, bottom: 5),
          color: const Color.fromARGB(255, 250, 250, 250),
          child: TextFormField(
            controller: _userPhoneController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),

              // labelText: 'Phone123',
              hintText: "Enter your mobile number",
              hintStyle: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(top: 10, left: 20, right: 30, bottom: 5),
          color: const Color.fromARGB(255, 250, 250, 250),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.always,
            controller: _userEmailController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter your email",
              hintStyle: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(top: 10, left: 20, right: 30, bottom: 5),
          color: const Color.fromARGB(255, 250, 250, 250),
          child: TextFormField(
            controller: _userAddressController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter your address",
              hintStyle: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
        const SizedBox(
          height: 200.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              padding:
                  const EdgeInsets.only(top: 1, bottom: 5, right: 30, left: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(255, 29, 121, 242),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _savePatient(
                        _userNameController.text,
                        _userPhoneController.text,
                        _userEmailController.text,
                        _userAddressController.text);
                  });
                },
                //  _savePatient(_userNameController.text,_userPhoneController.text,_userEmailController.text,_userAddressController.text),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
