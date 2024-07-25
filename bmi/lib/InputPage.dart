import 'package:bmi/tStyle.dart';
import 'package:flutter/material.dart';

import 'container.dart';
import 'iconandtext.dart';


enum Gender{
  male,
  female
}

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {

   Gender ? selectGen;
   int sHeight=180;
   int sliderw=60;
   int slidera=20;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: RepaeatContainer(
                        onPressed: (){
                          setState(() {
                            selectGen=Gender.male;
                          });
                        },
                        color: selectGen==Gender.male?activeColor:deActiveColor,
                        cardWidget: columnWidget(
                          ico: Icons.male,
                          txt: 'MALE',
                        ),
                      ),

                  ),
                  Expanded(
                      child: RepaeatContainer(
                        onPressed: (){
                          setState(() {
                            selectGen=Gender.female;
                          });
                        },
                        color: selectGen==Gender.female?activeColor:deActiveColor,
                        cardWidget: columnWidget(
                          ico: Icons.female,
                          txt: "FEMALE",
                        ),
                      ),

                  ),
                ],
              ),
            ),
            Expanded(
                child: new RepaeatContainer(
              color: Color(0xFF1D1E33),
                  cardWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('HEIGHT',
                      style: tStyle,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(sHeight.toString(),style: nStyle,),
                          Text('cm',style: tStyle),
                        ],
                      ),
                      Slider(value: sHeight.toDouble(),
                          min:120,
                          max:220,
                          activeColor: Color(0XFFEB1555),
                          inactiveColor: Color(0xFF8D8e98),
                          onChanged: (double newValue){
                        setState(() {
                          sHeight=newValue.round();

                        });
                          })
                    ],
                  ),
            )),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: new RepaeatContainer(
                    color: Color(0xFF1D1E33),
                        cardWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('WEIGHT',style: tStyle,),
                            Text(
                              sliderw.toString(),
                              style: nStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                              ],
                            )
                          ],
                        )
                        
                  )),
                  Expanded(
                      child: new RepaeatContainer(color: Color(0xFF1D1E33),
                          cardWidget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('AGE',style: tStyle,),
                              Text(
                                slidera.toString(),
                                style: nStyle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                ],
                              )
                            ],
                          )

                      )
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
