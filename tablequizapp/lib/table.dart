import 'package:flutter/material.dart';
import 'package:tablequizapp/generateTable.dart';
import 'package:tablequizapp/tstyle.dart';
import 'container.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  int table = 0;
  int start = 1;
  int end = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RepaeatContainer(
              color: const Color(0xFF1D1E33),
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Table #',
                    style: nStyle,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Text(
                        '0',
                      ),
                      Slider(
                        value: table.toDouble(),
                        min: 0,
                        max: 30,
                        divisions: 29,
                        label: table.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            table = value.round();
                          });
                        },
                      ),
                      Text(
                        '30',
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RepaeatContainer(
              color: const Color(0xFF1D1E33),
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start #',
                    style: nStyle,
                  ),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Text(
                        '1',
                      ),
                      Slider(
                        value: start.toDouble(),
                        min: 1,
                        max: 30,
                        label: start.round().toString(),
                        divisions: 29,
                        onChanged: (double newValue) {
                          setState(() {
                            start = newValue.round();
                          });
                        },
                      ),
                      Text(
                        '30',
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RepaeatContainer(
              color: const Color(0xFF1D1E33),
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'End #',
                    style: nStyle,
                  ),

                  SizedBox(height: 10,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Text(
                        '0',
                      ),
                      Slider(
                        value: end.toDouble(),
                        min: 1,
                        max: 50,
                        label: end.round().toString(),
                        divisions: 49,
                        onChanged: (double newValue) {
                          setState(() {
                            end = newValue.round();
                          });
                        },
                      ),
                      Text(
                        '50',
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => genTable(
                    tableNumber: table,
                    start: start,
                    end: end,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEB1555),
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0, // Border width
                ),
              ),
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 20,
                left: 50,
                right: 50,
              ),
              width: double.infinity,
              height: 50,
              child: const Center(
                child: Text(
                  "Generate Table",
                  style: nStyle
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
