import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeSlot {
  final String title;
  final String selection;
  final DateTime time;

  const TimeSlot({
    required this.title,
    required this.time,
    required this.selection,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      title: json['Title'],
      selection: json['selection'],
      time: DateTime.parse(json['Time']),
    );
  }
}

class BookingProvider extends StateNotifier<AsyncValue<TimeSlot>> {
  BookingProvider(this.location) : super(const AsyncValue.loading()) {
    fetchTimeSlot();
  }
  final String location;

  Future<void> fetchTimeSlot() async {
    final response = await http.post(
      Uri.parse('https://medi.bto.bistecglbal.com/api/SaveTimeSLot'),
      headers: <String, String>{
        'Content-Type': 'applicatio/json; cahrset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Title': '',
        'Selection': '',
        'Time': DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      final timeSlot = TimeSlot.fromJson(jsonDecode(response.body));
      state = AsyncValue.data(timeSlot);
    } else {
      throw Exception('Faild to create a file.');
    }
  }
}

final bookingProvider =
    StateNotifierProvider<BookingProvider, AsyncValue<TimeSlot>>(
  (ref) => BookingProvider(ref.watch(locationProvider)),
);

final locationProvider = Provider<String>((ref) => 'Your Location');

class Booking extends StatelessWidget {
  const Booking({Key? key, required String location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text("Delivery Schedule"),
    ));
  }
}
