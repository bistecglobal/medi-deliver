import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class Patient {
  final String yourName;
  final String phone;
  final String email;
  final String address;

  const Patient({
    required this.yourName,
    required this.phone,
    required this.email,
    required this.address,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        yourName: json['YourName'],
        phone: json['Phone'],
        email: json['Email'],
        address: json['Address']);
  }
  Map<String, dynamic> toJson() {
    return {
      'YourName': yourName,
      'Phone': phone,
      'Email': email,
      'Address': address,
    };
  }
}

class PatientFormNotifier extends ChangeNotifier {
  final TextEditingController userNameController =
      TextEditingController(text: '');
  final TextEditingController userPhoneController =
      TextEditingController(text: '');
  final TextEditingController userEmailController =
      TextEditingController(text: '');
  final TextEditingController userAddressController =
      TextEditingController(text: '');

  Future<void> savePatient() async {
    final patient = Patient(
      yourName: userNameController.text,
      phone: userPhoneController.text,
      email: userEmailController.text,
      address: userAddressController.text,
    );

    final response = await http.post(
      Uri.parse('https:medi.bto.bistecglobal.com/api/savePatient'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(patient.toJson()),
    );

    if (response.statusCode == 200) {
      print('Success: Patient Saved');
    } else {
      throw Exception('Faild to create patient');
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    userPhoneController.dispose();
    userEmailController.dispose();
    userAddressController.dispose();
    super.dispose();
  }
}

final patientProvider = Provider((ref) => PatientFormNotifier());

class Questions extends ConsumerWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientForm = ref.watch(patientProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bistec Care'),
      ),
      body: Consumer(builder: (context, watch, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(5)),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: const Text(
                'Let us Know about You',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 5, left: 20, right: 30, bottom: 5),
              color: const Color.fromARGB(255, 250, 250, 250),
              child: TextFormField(
                controller: patientForm.userNameController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter Your Name',
                    hintStyle: TextStyle(fontSize: 14.0)),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 1, left: 20, right: 30, bottom: 5),
              color: const Color.fromARGB(255, 250, 250, 250),
              child: TextFormField(
                controller: patientForm.userPhoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter your mobile number",
                  hintStyle: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 20, right: 30, bottom: 5),
              color: const Color.fromARGB(255, 250, 250, 250),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                controller: patientForm.userEmailController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter your email",
                  hintStyle: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 20, right: 30, bottom: 5),
              color: const Color.fromARGB(255, 250, 250, 250),
              child: TextFormField(
                controller: patientForm.userAddressController,
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
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(
                      top: 1, bottom: 5, right: 30, left: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 29, 121, 242),
                  ),
                  child: TextButton(
                    onPressed: () {
                      patientForm.savePatient().then((_) {
                        Navigator.pushNamed(context, '/trakOrder');
                      }).catchError((error) {
                        print('error');
                      });
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        );
      }),
    );
  }
}
