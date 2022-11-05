import 'package:flutter/material.dart';
import 'package:test_app/view/onboard/onboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnBoard(),
    );
  }
}


