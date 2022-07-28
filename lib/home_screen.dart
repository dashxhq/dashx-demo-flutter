import 'package:dashx_flutter/dashx_flutter.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class HomeScreen extends StatelessWidget {
  final DashX dx;
  const HomeScreen(this.dx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Text(dx.uuidValue.toString()),
                TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue)))),
                  onPressed: () async {
                    // Customise your track event based on your requirment. this is only for reference
                    await dx.track(
                        "Clicked Button", {"gameName": "Tetris", "click": "1"});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .2,
                    alignment: Alignment.center,
                    child: Text('Track Event'),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue)))),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    prefs.setBool("isLoggedIn", false);

                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(dx)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .2,
                    alignment: Alignment.center,
                    child: Text('Logout'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
