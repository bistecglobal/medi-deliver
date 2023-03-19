import 'package:flutter/material.dart';

import 'Upload.dart';
// import 'package:medi_deliver/Upload.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String dropdownvalue = 'Kalaniya Pharmacy';
  var items = [
    'Kalaniya Pharmacy',
    'Chandana Pharmacy',
    'Aruna Pharmacy',
    'Nawaloka Pharmacy',
    'Arogya Pharmacy',
  ];

  // ignore: non_constant_identifier_names
  void _Upload() {
    Navigator.pushNamed(context, '/upload');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Chathuranga Jayanath"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
              icon: const Icon(Icons.add_a_photo),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Select Your Pharmacy :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    DropdownButton(
                        value: dropdownvalue,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(color: Colors.pink),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        }),
                    DropdownButton<String>(
                      items: <String>['A', 'B', 'C', 'D'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    right: 20.0, left: 20.0, top: 1.0, bottom: 5.0),
                padding: const EdgeInsets.all(20.0),
                height: 185.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFF2196F3),
                ),
                child: Column(children: [
                  const Text(
                    "Let's Find Your Doctor",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.heart_broken),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.home),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.accessible_forward_outlined),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.bubble_chart),
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                padding: const EdgeInsets.all(20.0),
                height: 125,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFF2196F3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Covid-19",
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Vaccinations",
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Let's Stay Safe & Vaccinations",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    top: 5, right: 20, left: 20, bottom: 10),
                padding: const EdgeInsets.all(20.0),
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFF2196F3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Get Medicine",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Delivered to Doorstep",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Upload your prescription here",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                    IconButton(
                      onPressed: _Upload,
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_call),
              label: 'call',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'call',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.date_range),
              label: 'date_range',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'image',
            ),
          ],
          selectedItemColor: const Color.fromARGB(255, 36, 131, 240),
          unselectedItemColor: const Color.fromARGB(255, 36, 131, 240),
        ),
      ),
    );
  }
}
