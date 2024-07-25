import 'package:bmi/calculateData.dart';
import 'package:bmi/result.dart';
import 'package:bmi/tStyle.dart';
import 'package:flutter/material.dart';

import 'calculateData.dart';
import 'container.dart';
import 'iconandtext.dart';

enum Gender { male, female }

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  Gender? selectGen;
  int sHeight = 180;
  int sliderw = 60;
  int slidera = 20;

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
                      onPressed: () {
                        setState(() {
                          selectGen = Gender.male;
                        });
                      },
                      color: selectGen == Gender.male
                          ? activeColor
                          : deActiveColor,
                      cardWidget: columnWidget(
                        ico: Icons.male,
                        txt: 'MALE',
                      ),
                    ),
                  ),
                  Expanded(
                    child: RepaeatContainer(
                      onPressed: () {
                        setState(() {
                          selectGen = Gender.female;
                        });
                      },
                      color: selectGen == Gender.female
                          ? activeColor
                          : deActiveColor,
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
                  Text(
                    'HEIGHT',
                    style: tStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sHeight.toString(),
                        style: nStyle,
                      ),
                      Text('cm', style: tStyle),
                    ],
                  ),
                  Slider(
                      value: sHeight.toDouble(),
                      min: 120,
                      max: 220,
                      activeColor: Color(0XFFEB1555),
                      inactiveColor: Color(0xFF8D8e98),
                      onChanged: (double newValue) {
                        setState(() {
                          sHeight = newValue.round();
                        });
                      })
                ],
              ),
            )),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: RepaeatContainer(
                      color: Color(0xFF1D1E33),
                      cardWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('WEIGHT', style: tStyle),
                          Text(sliderw.toString(), style: nStyle),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIcon(
                                icondata: Icons.remove,
                                onPress: () {
                                  setState(() {
                                    sliderw--;
                                  });
                                },
                              ),
                              SizedBox(width: 10.0),
                              RoundIcon(
                                icondata: Icons.add,
                                onPress: () {
                                  setState(() {
                                    sliderw++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: new RepaeatContainer(
                          color: Color(0xFF1D1E33),
                          cardWidget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'AGE',
                                style: tStyle,
                              ),
                              Text(
                                slidera.toString(),
                                style: nStyle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundIcon(
                                    icondata: Icons.remove,
                                    onPress: () {
                                      setState(() {
                                        slidera--;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10.0),
                                  RoundIcon(
                                    icondata: Icons.add,
                                    onPress: () {
                                      setState(() {
                                        slidera++;
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ))),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                CalculateBrain calc =CalculateBrain(height: sHeight, weight: sliderw);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Result(
                  bmiR: calc.calculateBMI(),
                  interprataion: calc.getInterpretation(),
                  resultT: calc.getResult(),
                )));
              },
              child: Container(
                child: Center(
                    child: Text(
                  "Calculate",
                  style: cStyle,
                )),
                color: Color(0xFFEB1555),
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 80,
              ),
            )
          ],
        ));
  }
}

class RoundIcon extends StatelessWidget {
  final IconData icondata;
  final VoidCallback onPress;

  RoundIcon({required this.icondata, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icondata),
      onPressed: onPress,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        height: 56.0,
        width: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
