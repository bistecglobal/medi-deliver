import 'package:flutter/material.dart';

import 'trakOrder.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  final TextEditingController _userNameController =
      TextEditingController(text: null);
  final TextEditingController _userPhoneController =
      TextEditingController(text: null);
  final TextEditingController _userEmailController =
      TextEditingController(text: null);
  final TextEditingController _userAddressController =
      TextEditingController(text: null);

  // @override
  // void initState() {
  //   super.initState();
  //   _userNameController.addListener(() {
  //     final String text = _userNameController.text.toLowerCase();
  //     _userNameController.value = _userNameController.value.copyWith(
  //       text: text,
  //       selection:
  //           TextSelection(baseOffset: text.length, extentOffset: text.length),
  //       composing: TextRange.empty,
  //     );
  //   });
  // }

  void _trakOrder() {
    print(_userNameController);
    print(_userPhoneController);
    print(_userEmailController);
    print(_userAddressController);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return const TrakOrder();
      },
    ));
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    _userAddressController.dispose();
    _userEmailController.dispose();
    _userNameController.dispose();
    _userPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userNameController = "hello";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bistec care"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(padding: EdgeInsets.all(5)),
        Container(
          margin: const EdgeInsets.all(20),
          child: const Text(
            "Let us know more about you",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
          color: const Color.fromARGB(255, 232, 243, 249),
          child: TextFormField(
            controller: _userNameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: " Your name",
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
          color: const Color.fromARGB(255, 229, 244, 248),
          child: TextFormField(
            controller: _userPhoneController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: " Phone",
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
          color: const Color.fromARGB(255, 213, 236, 241),
          child: TextFormField(
            controller: _userEmailController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: " Email",
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
          color: const Color.fromARGB(255, 214, 230, 241),
          child: TextFormField(
            controller: _userAddressController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: " Address",
            ),
          ),
        ),
        const SizedBox(
          height: 225.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              padding:
                  const EdgeInsets.only(top: 1, bottom: 5, right: 30, left: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(255, 29, 121, 242),
              ),
              child: TextButton(
                onPressed: _trakOrder,
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}