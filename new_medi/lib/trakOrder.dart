// ignore: file_names

import 'package:flutter/material.dart';

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

  String value = "1500.00";
  String status = "on the way1";
  String deliveredDate = "2023 / 03 / 20";
  String orderID = "1198347";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Track your order",
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 120,
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 251, 248, 248),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('images/Group 50.png'),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(status),
                        Text("Total payable : $value "),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Order ID: $orderID"),
                        const SizedBox(
                          width: 4,
                        ),
                        const TextButton(
                            onPressed: null, child: Text('View Order')),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: (EdgeInsets.only(left: 30, top: 40))),
                    const Text(
                      "Past Orders",
                    ),
                  ],
                ),
                Container(
                  height: 120,
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 251, 248, 248),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('images/Group 53.png'),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 35)),
                        Text("Delivered on:$deliveredDate"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Order ID: $orderID"),
                        const SizedBox(
                          width: 4,
                        ),
                        const TextButton(
                            onPressed: null, child: Text('View Order')),
                      ],
                    ),
                  ],
                ),
                const Divider(),
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
