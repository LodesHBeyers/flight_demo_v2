import 'package:flight_demo_v2/temp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Material(child: Temp()),
    );
  }
}
