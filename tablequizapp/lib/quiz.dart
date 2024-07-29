import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:tablequizapp/question.dart';
import 'package:tablequizapp/tstyle.dart';
import 'container.dart';
import 'quiz_brain.dart';

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

  List<Color> buttonColors = [Color(0xFF1D1E33), Color(0xFF1D1E33), Color(0xFF1D1E33)];

  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    questions = generateQuestions(widget.tableNumber, widget.start, widget.end);
    quizBrain.setQuestions(questions);  // Update the questions in quizBrain
  }

  void PlaySound(String fileName) {
    AssetsAudioPlayer.newPlayer().open(
      Audio('assets/$fileName'),
    );
  }

  void count() {
    ++correctAnswers;
  }

  void checkAnswer(int userPickedAnswer) {
    int correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (questionIndex >= maxQuestions) {
        // Show result dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Quiz Complete'),
              content: Text(
                'Congratulations! You have completed the quiz.\n'
                    'Total Questions: $maxQuestions\n'
                    'Correct Answers: $correctAnswers\n',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    PlaySound('note7.mp3');// Close the dialog
                    Navigator.pop(context); //
                    quizBrain.reset();
                    scoreKeeper = [];
                    questionIndex = 0; // Navigate back to previous page or home page
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Reset question index
      } else {
        if (userPickedAnswer == correctAnswer) {
          PlaySound('note1.wav'); // Correct answer sound
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          feedbackText = 'GOOD'; // Set positive feedback for correct answer
          count(); // Increment correct answers count
        } else {
          PlaySound('note6.mp3'); // Incorrect answer sound
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
    return generatedQuestions.take(maxQuestions).toList(); // Take only the first maxQuestions items
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
            child: RepaeatContainer(
              color: const Color(0xFF1D1E33),
              cardWidget: Padding(
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
          ),
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


          ...options.asMap().entries.map((entry) {
            int index = entry.key;
            var option = entry.value;
            return Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(buttonColors[index % buttonColors.length]),
                ),
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
              GestureDetector(
                onTap: () {
                  PlaySound('note7.mp3');
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEB1555),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.black, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  height: 50,
                  width: 170,
                  child: const Center(
                    child: Text(
                        "Generate Table",
                        style: nStyle
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (questionIndex < maxQuestions - 1) {
                    setState(() {
                      PlaySound('note7.mp3');
                      quizBrain.nextQuestion();
                      ++questionIndex;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEB1555),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.black, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  height: 50,
                  width: 170,
                  child: const Center(
                    child: Text(
                        "Next Question",
                        style: nStyle
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }
}
