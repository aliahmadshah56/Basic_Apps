import 'package:flutter/material.dart';
import 'package:tablequizapp/quiz.dart';
import 'package:tablequizapp/tstyle.dart';

// Import your custom container
import 'container.dart';

class genTable extends StatelessWidget {
  final int tableNumber;
  final int start;
  final int end;

  genTable({required this.tableNumber, required this.start, required this.end});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table of $tableNumber'),
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
                  Expanded(
                    child: Center(
                      child: ListView.builder(
                        itemCount: end - start + 1,
                        itemBuilder: (context, index) {
                          int value = start + index;
                          return ListTile(
                            title: Text(
                              '$tableNumber x $value = ${tableNumber * value}',
                              style: tStyle,
                            ),
                          );
                        },
                      ),
                    ),
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
                  builder: (context) => QuizPage(tableNumber: tableNumber,start: start,end: end,

                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEB1555),
                borderRadius: BorderRadius.circular(8.0),
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
                child: Text("Generate QUIZ", style: nStyle),
              ),
            ),
          )
        ],
      ),
    );
  }
}
