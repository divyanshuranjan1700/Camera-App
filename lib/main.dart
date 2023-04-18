import 'package:flutter/material.dart';
import 'package:flutter_camera_demo/screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
