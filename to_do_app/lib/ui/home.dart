import 'package:flutter/material.dart';
import 'package:to_do_app/ui/todoscreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('To Do'),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 25),
        backgroundColor: Colors.black54,
    ),
    body: ToDoScreen(),);
  }
}
