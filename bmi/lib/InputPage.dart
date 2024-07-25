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
  Color maleColor = deActiveColor;
  Color femaleColor = deActiveColor;

  void updateColor(Gender gen) {
    if (gen == Gender.male) {
      maleColor = activeColor;
      femaleColor = deActiveColor;
    }
    if (gen == Gender.female) {
      maleColor = deActiveColor;
      femaleColor = activeColor;
    }
  }

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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          updateColor(Gender.male);
                        });
                      },
                      child: RepaeatContainer(
                        color: maleColor,
                        cardWidget: columnWidget(
                          ico: Icons.male,
                          txt: 'MALE',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          updateColor(Gender.female);
                        });
                      },
                      child: RepaeatContainer(
                        color: femaleColor,
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
