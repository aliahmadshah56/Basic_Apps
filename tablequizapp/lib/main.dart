import 'package:flutter/material.dart';
import 'package:tablequizapp/table.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TablePage(),
      theme: ThemeData.dark(),
    );
  }
}