import 'package:dashx_flutter/dashx_flutter.dart';
import 'package:dashx_flutter_example/constant.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

import 'home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SampleApp());
  }
}

class SampleApp extends StatefulWidget {
  const SampleApp({Key? key}) : super(key: key);

  @override
  State<SampleApp> createState() => _SampleAppState();
}

class _SampleAppState extends State<SampleApp> {
  String message = 'Unknown';
  String uid = '';
  String password = '';
  String email = '';
  String error_message = '';
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  DashXPlugin dashxFlutterPlugin = DashXPlugin();
  DashX dx = DashX(
    publicKey: publicKey,
    baseUri: baseUri,
    targetEnvironment: targetEnvironment,
  );

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    try {
      dashxFlutterPlugin;
      uid = await dx.getUuid().then((value) => value);
    } on PlatformException {
      message = 'Failed set values.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plugin Eample App')),
      body: Center(
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
                        print(
                            'before ${email_controller.text}  ${password_controller.text}');
                      } else {
                        setState(() {});
                        print(
                            'after ${email_controller.text}  ${password_controller.text}');
                        // Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(dxObj: dx)));
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
                              builder: (context) => RegisterScreen(dxObj: dx)));
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
      appBar: AppBar(title: Text('Plugin Eample App')),
      body: Center(
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
                    obscureText: true,
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
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(dxObj: widget.dxObj)));
                      }
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
    );
  }
}
