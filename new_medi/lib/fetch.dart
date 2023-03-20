import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      'https://medi.bto.bistecglobal.com/api/GetMedicalCenters?pageNumber=1&pageSize=1'));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);

    // Map each object in the array to an instance of the Album class
    final albums = jsonResponse.map((album) => Album.fromJson(album)).toList();
    return albums;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String m_Name;
  final String m_Location;

  const Album({
    required this.m_Name,
    required this.m_Location,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      m_Name: json['m_Name'],
      m_Location: json['m_Location'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum() as Future<Album>;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.m_Location);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
