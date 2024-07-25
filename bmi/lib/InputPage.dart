import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RepaeatContainer(color: Color(0xFF1D1E33)),
                ),
                Expanded(
                  child: RepaeatContainer(color: Color(0xFF1D1E33)),
                ),
              ],
            ),
          ),

          Expanded(
              child: new RepaeatContainer(color: Color(0xFF1D1E33))
          ),
          Expanded(
            child: Row(
            children: [
              Expanded(
                  child: new RepaeatContainer(color: Color(0xFF1D1E33))
            ),
              Expanded(
                  child:new RepaeatContainer(color: Color(0xFF1D1E33))
              ),


            ],
          ),),
        ],
      )
    );
  }
}

class RepaeatContainer extends StatelessWidget {
  final Color color;

  const RepaeatContainer({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}