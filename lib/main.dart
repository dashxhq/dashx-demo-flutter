import 'dart:convert';

import 'package:dashx_flutter/dashx_flutter.dart';
import 'package:dashx_flutter_example/constant.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DashX dx = DashX(
    publicKey: publicKey,
    baseUri: baseUri,
    targetEnvironment: targetEnvironment,
  );
  await dx.getUuid();
  print("main: uuid = ${dx.uuidValue}");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  runApp(MaterialApp(home: status == true ? HomeScreen(dx) : LoginScreen(dx)));
}

class LoginScreen extends StatefulWidget {
  final DashX dx;
  const LoginScreen(this.dx);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String error_message = '';
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plugin Eample App')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                'Login to your account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        error_message,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Email'),
                    TextField(
                      controller: email_controller,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Password'),
                    TextField(
                      controller: password_controller,
                      obscureText: true,
                      autofocus: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (email_controller.text.length == 0 ||
                            password_controller.text.length == 0) {
                          error_message = 'Check credentials.';
                          setState(() {});
                        } else {
                          setState(() {});
                          await widget.dx.login({
                            'email': email_controller.text,
                            'password': password_controller.text
                          });

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', true);
                          var values =
                              json.decode(widget.dx.responseMessage!.body);
                          Map<String, dynamic> map = values;
                          prefs.setString('token', map.values.last);
                          prefs.setString('uuid', widget.dx.uuidValue!);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(widget.dx)));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Login'),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.blue)))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegisterScreen(dxObj: widget.dx)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Register'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  final DashX dxObj;
  RegisterScreen({required this.dxObj, Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String error_message = '';
  TextEditingController firstname_controller = TextEditingController();
  TextEditingController lastname_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plugin Example App')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                'Register your account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        error_message,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('First Name'),
                    TextField(
                      controller: firstname_controller,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Last Name'),
                    TextField(
                      controller: lastname_controller,
                      autofocus: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Email'),
                    TextField(
                      controller: email_controller,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Password'),
                    TextField(
                      controller: password_controller,
                      obscureText: true,
                      autofocus: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.blue)))),
                      onPressed: () async {
                        if (firstname_controller.text.length == 0 ||
                            lastname_controller.text.length == 0 ||
                            email_controller.text.length == 0 ||
                            password_controller.text.length == 0) {
                          error_message = 'Check details.';
                          setState(() {});
                        } else {
                          setState(() {});

                          await widget.dxObj.register({
                            "first_name": firstname_controller.text,
                            "last_name": lastname_controller.text,
                            "email": email_controller.text,
                            "password": password_controller.text
                          });
                          // add this line to see respose.
                          print(widget.dxObj.responseMessage!.statusCode);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setBool('isLoggedIn', true);
                          prefs.setString('dx', widget.dxObj.toString());
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(widget.dxObj),
                            ),
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Register'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
