import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackOrder {
  final String value;
  final String status;
  final String deliveryDate;
  final String orderID;

  TrackOrder({
    required this.value,
    required this.status,
    required this.deliveryDate,
    required this.orderID,
  });
}

class TrackOrderNotifier extends ChangeNotifier {
  String value = "1500.00";
  String status = "On the way!";
  String deliveryDate = "31/10/2023";
  String orderID = "00010";
}

final trackOrderProvider =
    ChangeNotifierProvider((ref) => TrackOrderNotifier());

class TrackOrderPage extends ConsumerWidget {
  const TrackOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackOrder = ref.watch(trackOrderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Your Order"),
      ),
      body: ListView(
        children: [
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
                  image: const DecorationImage(image: AssetImage('')),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(trackOrder.status),
                      Text("Total Payble: ${trackOrder.value}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Order ID: ${trackOrder.orderID}"),
                      const SizedBox(width: 4),
                      const TextButton(
                        onPressed: null,
                        child: Text("View Order"),
                      ),
                    ],
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 40),
                  ),
                  Text(
                    "Past Orders",
                  ),
                ],
              ),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 251, 248, 248),
                  ),
                  image: const DecorationImage(
                    image: AssetImage("assetName"),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 30)),
                      Text("Delivery On: ${trackOrder.deliveryDate}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Order ID : ${trackOrder.orderID}"),
                      const SizedBox(width: 4),
                      const TextButton(
                        onPressed: null,
                        child: Text('View Order'),
                      ),
                    ],
                  )
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Go Back to Login Page",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
