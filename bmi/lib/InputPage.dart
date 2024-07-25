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
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFF101E33),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  )
              ),
              Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Color(0xFF101E33),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  )
              ),
            ],
          ),),
          Expanded(child: Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Color(0xFF101E33),
                borderRadius: BorderRadius.circular(10)
            ),
          )),
          Expanded(
            child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Color(0xFF101E33),
                      borderRadius: BorderRadius.circular(10)
                  ),
                )
            ),
              Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Color(0xFF101E33),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  )
              ),


            ],
          ),),
        ],
      )
    );
  }
}