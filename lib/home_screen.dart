import 'package:dashx_flutter/dashx_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final DashX dxObj;
  HomeScreen({required this.dxObj, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(children: [
          Text('Status Code:' + dxObj.responseMessage!.statusCode.toString()+ '\t' + dxObj.responseMessage!.body ),
  
        ]),
      ),
    );
  }
}
