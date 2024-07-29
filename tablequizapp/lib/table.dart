import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'generateTable.dart';
import 'tstyle.dart';
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

  void PlaySound(String fileName) {
    AssetsAudioPlayer.newPlayer().open(
      Audio('assets/$fileName'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Generator'),
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
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      const Text('0'),
                      Slider(
                        value: table.toDouble(),
                        min: 0,
                        max: 30,
                        divisions: 30,
                        label: table.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            table = value.round();
                          });
                        },
                      ),
                      const Text('30'),
                      const Spacer(),
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
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      const Text('0'),
                      Slider(
                        value: start.toDouble(),
                        min: 0,
                        max: 30,
                        label: start.round().toString(),
                        divisions: 30,
                        onChanged: (double newValue) {
                          setState(() {
                            start = newValue.round();
                          });
                        },
                      ),
                      const Text('30'),
                      const Spacer(),
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
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      const Text('1'),
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
                      const Text('50'),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              PlaySound('note7.mp3');
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
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
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
                  style: nStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
