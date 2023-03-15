// ignore: file_names
import 'package:flutter/material.dart';

import 'dashbord.dart';

class TrakOrder extends StatefulWidget {
  const TrakOrder({super.key});

  @override
  State<TrakOrder> createState() => _TrakOrderState();
}

class _TrakOrderState extends State<TrakOrder> {
  // ignore: non_constant_identifier_names
  void _DashBoard() {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Trak your order",
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('images/processingDel.jpg'),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('images/pac.jpg'),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('images/comming.jpg'),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('images/doorstep.jpg'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromARGB(255, 29, 121, 242),
                      ),
                      child: TextButton(
                        onPressed: _DashBoard,
                        child: const Text(
                          "Go back to login page",
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}