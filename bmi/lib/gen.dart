import 'package:bmi/tStyle.dart';
import 'package:flutter/material.dart';
import 'InputPage.dart';
import 'container.dart';
import 'iconandtext.dart';

enum Gender { male, female }

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  Gender? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: const Text(
          'Select Gender',
          style: tStyle,
        )),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: RepaeatContainer(
                      onPressed: () {
                        setState(() {
                          selectedGender = Gender.male;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Input(
                                selectedGender: selectedGender!,
                              ),
                            ),
                          );
                        });
                      },
                      color: selectedGender == Gender.male
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
                          selectedGender = Gender.female;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Input(
                                selectedGender: selectedGender!,
                              ),
                            ),
                          );
                        });
                      },
                      color: selectedGender == Gender.female
                          ? activeColor
                          : deActiveColor,
                      cardWidget: columnWidget(
                        ico: Icons.female,
                        txt: 'FEMALE',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
