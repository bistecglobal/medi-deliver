import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'questions.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String dropdownvalue1 = '09.00 a.m';
  var items1 = [
    '11.00 a.m',
    '12.00 a.m',
    '03.00 p.m',
    '05.00 p.m',
    '07.00 p.m',
  ];

  String dropdownvalue2 = '09.00 a.m';
  var items2 = [
    '11.00 a.m',
    '12.00 a.m',
    '03.00 p.m',
    '05.00 p.m',
    '07.00 p.m',
  ];

  void Question() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return const Questions();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Shedule"),
      ),
      body: Column(
        children: [
          Container(
            height: 360,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 201, 228, 250),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2033, 10, 26),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Preffered Time Slots"),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton(
                          value: dropdownvalue1,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          items: items1.map((String items) {
                            return DropdownMenuItem(
                              child: Text(
                                items,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 9, 169, 20)),
                              ),
                              value: items,
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue1 = newValue!;
                            });
                          }),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 137, 193, 238),
                        ),
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "09.00 a.m",
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 139, 199, 155),
                        ),
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "11.00 a.m",
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 242, 179, 133),
                        ),
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "12.00 a.m",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 235, 169, 218),
                        ),
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "03.00 p.m",
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 172, 243, 192),
                        ),
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "05.00 p.m",
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 169, 163, 245),
                        ),
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "07.00 p.m",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
