import 'package:flutter/material.dart';
import 'package:medi_deliver/Upload.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text("DashBoard"),
            leading: Icon(Icons.home),
            actions: [
              Icon(
                Icons.search,
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return Upload();
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
