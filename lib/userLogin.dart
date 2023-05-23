import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCredentials {
  final String username;
  final String password;

  const UserCredentials({required this.username, required this.password});

  factory UserCredentials.fromJson(Map<String, dynamic> json) {
    return UserCredentials(
      username: json['username'],
      password: json['password'],
    );
  }
}

final loginProvider = Provider.autoDispose<LoginBloc>(
  (ref) => LoginBloc(ref.container),
);

class LoginState {
  final bool isLoading;
  final bool success;
  final String? error;

  LoginState({
    this.isLoading = false,
    this.success = false,
    this.error,
  });
}

class LoginBloc {
  final ProviderContainer container;

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();
  late final StreamController<bool> _isLoadingController;
  Stream<bool> get isLoadingStream => _isLoadingController.stream;
  final _loginStateController = StateController<LoginState>(LoginState());

  LoginBloc(this.container) {
    _isLoadingController = StreamController<bool>.broadcast();
  }

  void dispose() {
    _userIdController.dispose();
    _userPassController.dispose();
    _isLoadingController.close();
    _loginStateController.dispose();
  }

  Future<void> login(String username, String password) async {
    _isLoadingController.add(true);

    try {
      final response = await http.post(
        Uri.parse('http://medi.bto.bistecglobal.com/api/Function1'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        _loginStateController.state = LoginState(success: true);
      } else {
        throw Exception('Faild to create.');
      }
    } catch (e) {
      _loginStateController.state = LoginState(error: e.toString());
    } finally {
      _isLoadingController.add(false);
    }
  }

  void resetLoginState() {
    _loginStateController.state = LoginState();
  }
}

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(loginProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 470.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Log ino Your Account",
                  style: TextStyle(
                    color: Color.fromARGB(255, 28, 146, 243),
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20),
                  child: TextField(
                    controller: bloc._userIdController,
                    style: const TextStyle(fontSize: 20.0),
                    autofocus: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Password"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Forgot Password",
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 50, right: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xFF2196F3),
                  ),
                  child: StreamBuilder<bool>(
                    stream: bloc.isLoadingStream,
                    initialData: false,
                    builder: (context, snapshot) {
                      final isLoading = snapshot.data ?? false;
                      return TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                bloc.login(
                                  bloc._userIdController.text,
                                  bloc._userPassController.text,
                                );
                              },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Don't have an Account?"),
                      SizedBox(width: 10.0),
                      Text(
                        "Sign Up here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                if (bloc._loginStateController.state.error != null)
                  Text(
                    bloc._loginStateController.state.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
