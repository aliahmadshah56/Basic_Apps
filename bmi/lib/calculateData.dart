import 'dart:math';

class CalculateBrain{

  final int height;
  final int weight;
  late double _bmi;

  CalculateBrain({required this.height, required this.weight});

  String calculateBMI(){
    _bmi=weight/pow(height/100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult(){
    if(_bmi>=25)
      {
        return "OverWeight";
      }
    else if(_bmi>18.5)
      {
        return "Normal";
      }
    else
      {
        return "UnderWeight";
      }
  }

  String getInterpretation(){
    if(_bmi>=25)
    {
      return "You have a higher then normal body Weight";
    }
    else if(_bmi>18.5)
    {
      return "You have a normal body Weight";
    }
    else
    {
      return "You have a lower than normal body weight";
    }

  }
}