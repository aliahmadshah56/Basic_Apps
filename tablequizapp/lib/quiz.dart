import 'package:flutter/material.dart';
import 'package:tablequizapp/question.dart';
import 'quiz_brain.dart';
import 'dart:math';

class QuizPage extends StatefulWidget {
  final int tableNumber;
  final int start;
  final int end;

  QuizPage({required this.tableNumber, required this.start, required this.end});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int questionIndex = 0;
  final int maxQuestions = 5; // Maximum number of questions
  String feedbackText = ''; // Feedback text variable
  int correctAnswers = 0; // Track the number of correct answers

  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    questions = generateQuestions(widget.tableNumber, widget.start, widget.end);
    quizBrain.setQuestions(questions);  // Update the questions in quizBrain
  }

  void checkAnswer(int userPickedAnswer) {
    int correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (questionIndex >= maxQuestions - 1 || quizBrain.isFinished()) {
        // Show result dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Quiz Complete'),
              content: Text(
                  'Congratulations! You have completed the quiz.\n'
                      'Total Questions: $maxQuestions\n'
                      'Correct Answers: $correctAnswers\n'
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.pop(context); // Navigate back to previous page or home page
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        // Reset quiz
        quizBrain.reset();
        scoreKeeper = [];
        questionIndex = 0; // Reset question index
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          feedbackText = 'GOOD'; // Set positive feedback for correct answer
          correctAnswers++; // Increment correct answers count
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
          feedbackText = 'Incorrect. The correct answer is $correctAnswer'; // Show correct answer if wrong
        }
        quizBrain.nextQuestion();
        questionIndex++;
      }
    });
  }

  List<Question> generateQuestions(int tableNumber, int start, int end) {
    List<Question> generatedQuestions = [];
    for (int i = start; i <= end; i++) {
      generatedQuestions.add(Question('$tableNumber x $i', tableNumber * i));
    }
    generatedQuestions.shuffle(); // Randomize the order of questions
    return generatedQuestions.take(maxQuestions).toList(); // Take only the first `maxQuestions` items
  }

  @override
  Widget build(BuildContext context) {
    List<int> options = quizBrain.generateOptions();
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          ...options.map((option) {
            return Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  checkAnswer(option);
                },
                child: Text(
                  option.toString(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to generate table page
                  Navigator.pop(context);
                },
                child: Text('Generate Table'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (questionIndex < maxQuestions - 1) {
                    setState(() {
                      quizBrain.nextQuestion();
                      questionIndex++;
                    });
                  }
                },
                child: Text('Next Question'),
              ),
            ],
          ),
          Row(
            children: scoreKeeper,
          ),
          // Display feedback text here
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                feedbackText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.yellow, // Adjust color as needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
