import 'package:quiz_app/question.dart';

class Quiz1 {
  int _qno = 0;
  List<Question> _questionBank = [
    Question('C++ was developed by Bjarne Stroustrup.', true),
    Question('C++ is a purely procedural programming language.', false),
    Question('The "main" function is the entry point of a C++ program.', true),
    Question('In C++, "cin" is used for output.', false),
    Question('C++ supports both procedural and object-oriented programming.', true),
    Question('A class in C++ cannot have private members.', false),
    Question('The extension for C++ header files is ".h".', true),
    Question('C++ supports function overloading.', true),
    Question('In C++, "new" is used to dynamically allocate memory.', true),
    Question('A constructor in C++ can return a value.', false),

  ];

  void nextQ() {
    if (_qno < _questionBank.length - 1) {
      _qno++;
    }
  }

  String getQ() {
    return _questionBank[_qno].questionText;
  }

  bool getAns() {
    return _questionBank[_qno].questionAnswer;
  }

  bool finish() {
    if (_qno >= _questionBank.length - 1)
      return true;
    else
      return false;
  }

  void reset() {
    _qno = 0;
  }
}
