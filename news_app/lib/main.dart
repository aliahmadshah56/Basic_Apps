// lib/main.dart
import 'package:flutter/material.dart';
import 'news_selection_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      home: NewsSelectionPage(),
    );
  }
}
