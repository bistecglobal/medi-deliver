import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Pharmacy>> getPhamacies() async {
  final response = await http.get(Uri.parse(
      'https://medi.bto.bistecglobal.com/api/GetMedicalCenters?pageNumber=1&pageSize=10'));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    print(response.body);
    // Map each object in the array to an instance of the Album class
    final List<Pharmacy> pharmacies = jsonResponse
        .map<Pharmacy>((album) => Pharmacy.fromJson(album))
        .toList();
    print(pharmacies);

    // setState(() {
    //   var items = pharmacies.map<String>((e) => e.M_Name).toList();
    //   String dropdownvalue = items[0];
    // });
    return pharmacies;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Pharmacy {
  final String M_Name;
  final String M_Location;

  const Pharmacy({
    required this.M_Name,
    required this.M_Location,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      M_Name: json['M_Name'],
      M_Location: json['M_Location'],
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late String _mySelection;
  List data = List.empty();

  var dropdownvalue;

  @override
  void initState() {
    super.initState();
  }

  final items = getPhamacies();

  // ignore: non_constant_identifier_names
  void _Upload() {
    Navigator.pushNamed(context, '/upload');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: items,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  title: const Text("Chathuranga Jayanath"),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('This is a snackbar')));
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
                              items: snapshot.data?.map((Pharmacy item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item.M_Name,
                                    style: const TextStyle(color: Colors.pink),
                                  ),
                                );
                              }).toList(),
                              onChanged: (Object? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                            DropdownButton<String>(
                              items: <String>['A', 'B', 'C', 'D']
                                  .map((String value) {
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
                                child: const Icon(
                                    Icons.accessible_forward_outlined),
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
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
