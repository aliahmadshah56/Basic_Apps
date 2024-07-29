import 'question.dart';
import 'dart:math';

class QuizBrain {
  int _questionNumber = 0;
  late List<Question> _questionBank;

  void setQuestions(List<Question> questions) {
    _questionBank = questions;
    _questionNumber = 0; // Reset question number when setting new questions
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  int getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }

  List<int> generateOptions() {
    int correctAnswer = getCorrectAnswer();
    Set<int> options = {correctAnswer};
    Random random = Random();
    while (options.length < 3) {
      options.add(random.nextInt(100) + 1);
    }
    List<int> optionList = options.toList();
    optionList.shuffle();
    return optionList;
  }
}

QuizBrain quizBrain = QuizBrain();
