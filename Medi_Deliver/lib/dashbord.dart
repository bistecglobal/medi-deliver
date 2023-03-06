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

  void _Upload() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return const Upload();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chathuranga Jayanath"),
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
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Select Your Pharmacy :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  DropdownButton(
                      value: dropdownvalue,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          child: Text(
                            items,
                            style: TextStyle(color: Colors.pink),
                          ),
                          value: items,
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      }),
                ],
              ),
            ),
            Container(
              child: Column(children: [
                Text(
                  "Let's Find Your Doctor",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.heart_broken),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.home),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.accessible_forward_outlined),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.bubble_chart),
                    ),
                  ],
                )
              ]),
              margin: EdgeInsets.only(
                  right: 20.0, left: 20.0, top: 10.0, bottom: 10.0),
              padding: EdgeInsets.all(20.0),
              height: 180.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF2196F3),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Covid-19",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Vaccinations",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Let's Stay Safe & Vaccinations",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF2196F3),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get Medicine",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Delivered to Doorstep",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Upload your prescription here",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                  IconButton(
                    onPressed: _Upload,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
              padding: EdgeInsets.all(20.0),
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF2196F3),
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
        selectedItemColor: Color.fromARGB(255, 36, 131, 240),
        unselectedItemColor: Color.fromARGB(255, 36, 131, 240),
      ),
    );
  }
}
