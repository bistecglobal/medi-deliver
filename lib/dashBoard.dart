import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pharmacy {
  final String mName;
  final String mLocation;

  const Pharmacy({
    required this.mName,
    required this.mLocation,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      mName: json['M_Name'],
      mLocation: json['M_Location'],
    );
  }
}

class DashBoard extends StatefulWidget {
  final String value;

  const DashBoard({Key? key, required this.value}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String myValue = '';
  Pharmacy? dropdownValue;
  late Future<List<Pharmacy>> pharmacies;

  @override
  void initState() {
    super.initState();
    myValue = widget.value;
    pharmacies = _getPharmacies();
  }

  Future<List<Pharmacy>> _getPharmacies() async {
    final response = await http.get(Uri.parse(
        'https://medi.bto.bistecglobal.com/api/GetMedicalCenters?pageNumber=1&pageSize=10'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<Pharmacy> pharmacies = (jsonResponse as List)
          .map((album) => Pharmacy.fromJson(album))
          .toList();
      return pharmacies;
    } else {
      throw Exception('Failed to load pharmacies');
    }
  }

  void upload() {
    if (dropdownValue != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Upload(location: dropdownValue!.mName)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a pharmacy')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pharmacy>>(
        future: pharmacies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Pharmacy>? pharamacyList = snapshot.data;

            if (pharamacyList != null && pharamacyList.isNotEmpty){
              return MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    title: Text(myValue),
                    actions: <Widget>[
                      IconButton(
                        onPressed: (){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('This is a snack Bar')),
                          );
                        },
                        icon: const Icon(Icons.add_a_photo),
                        ),
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
                                  'Select Your Phamacy :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                  ),
                                  ),
                                
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              )
            }
          }
        });
  }
}
