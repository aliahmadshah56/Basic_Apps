import 'package:bmi/tStyle.dart';
import 'package:flutter/material.dart';

import 'InputPage.dart';
import 'container.dart';

class Result extends StatelessWidget {
  Result({required this.bmiR,required this.interprataion,required this.resultT});
 final String bmiR;
 final String resultT;
 final String interprataion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Container(
            child: Center(
              child: Text(
                'Your Result',
                style: titleStyle,
              ),
            ),
          ),),

          Expanded(
              flex: 5,
              child: RepaeatContainer(
            color: activeColor,
            cardWidget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(resultT.toUpperCase(),
                style: noStyle,),
                Text(bmiR,
               style: numStyle
                ),
                Text(interprataion,
               style: linestyle,
                ),
              ],
            ),
          )),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Input()));
            },
            child: Container(
              child: Center(child: Text("Recalculate",style: cStyle,)),
              color: Color(0xFFEB1555),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 100,
            ),
          )

        ],
      )
    );
  }
}
