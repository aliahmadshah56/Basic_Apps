// lib/main.dart
import 'package:flutter/material.dart';
import 'display.dart'; // Import the file where BottomNavPage is defined

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      home: BottomNavPage(), // Update this to use BottomNavPage
    );
  }
}
