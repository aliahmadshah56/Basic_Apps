import 'package:flutter/material.dart';

import 'container.dart';
import 'iconandtext.dart';

const activeColor = Color(0xFF1D1E33);
const deActiveColor = Color(0xFF111328);
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
                  ),
                ],
              ),
            ),
            Expanded(
                child: new RepaeatContainer(
              color: Color(0xFF1D1E33),
            )),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: new RepaeatContainer(
                    color: Color(0xFF1D1E33),
                  )),
                  Expanded(
                      child: new RepaeatContainer(color: Color(0xFF1D1E33))),
                ],
              ),
            ),
          ],
        ));
  }
}
