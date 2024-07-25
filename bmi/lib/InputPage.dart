import 'package:flutter/material.dart';

import 'container.dart';
import 'iconandtext.dart';


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
                  child: RepaeatContainer(
                      color: Color(0xFF1D1E33),
                       cardWidget:  columnWidget(ico: Icons.male, txt: 'MALE',),
                  ),
                ),
                Expanded(
                  child: RepaeatContainer(
                      color: Color(0xFF1D1E33),
                    cardWidget:  columnWidget(ico: Icons.female,txt: "FEMALE",),
                  ),

                ),
              ],
            ),
          ),

          Expanded(
              child: new RepaeatContainer(
                  color: Color(0xFF1D1E33),
              )
          ),
          Expanded(
            child: Row(
            children: [
              Expanded(
                  child: new RepaeatContainer(
                      color: Color(0xFF1D1E33),
                    )
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



