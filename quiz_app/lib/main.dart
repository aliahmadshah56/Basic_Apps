import 'dart:async';
import 'package:flutter/material.dart';

import 'package:quiz_app/quiz1.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'CustomPainter.dart';

Quiz1 quizBrain = Quiz1();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Icon> scorekeeper = [];
  int t = 0;
  int f = 0;
  Timer? _timer;
  int _remainingTime = 5;

  void startTimer() {
    _timer?.cancel(); // Cancel any previous timer
    _remainingTime = 5;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          handleTimeout();
        }
      });
    });
  }

  void handleTimeout() {
    setState(() {
      f++;
      scorekeeper.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
      quizBrain.nextQ();
      startTimer(); // Restart the timer for the next question
    });
  }

  void checkans(bool a) {
    bool ans = quizBrain.getAns();
    setState(() {
      if (quizBrain.finish() == true) {

        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        quizBrain.reset();
        scorekeeper = [];
      } else {
        if (a == ans) {
          t++;
          scorekeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          f++;
          scorekeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQ();
        startTimer(); // Start timer for the next question
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer(); // Start timer when the widget is first created
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                child: CustomPaint(
                  painter: ClockPainter(_remainingTime),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "True: $t | False: $f",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    textAlign: TextAlign.center,
                    quizBrain.getQ(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: Text(
                      'True',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      _timer?.cancel(); // Cancel the timer when the user answers
                      checkans(true);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Text(
                      'False',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      _timer?.cancel(); // Cancel the timer when the user answers
                      checkans(false);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: scorekeeper,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
