import 'package:dashx_flutter/dashx_flutter.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class HomeScreen extends StatelessWidget {
  final DashX dx = DashX(
    publicKey: publicKey,
    baseUri: baseUri,
    targetEnvironment: targetEnvironment,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(children: [
          Text('Hello'),
        ]),
      ),
    );
  }
}
