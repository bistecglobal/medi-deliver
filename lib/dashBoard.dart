import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pharmacy {
  final String name;
  final String location;

  const Pharmacy({
    required this.name,
    required this.location,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      name: json['P_name'],
      location: json['P_Location'],
    );
  }
}

class DashBoard extends StatefulWidget {
  final String value;
  const DashBoard({Key? key, required this.value}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late String myValue;
  late String dropdownValue;
  late Future<List<Pharmacy>> pharmacies;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
