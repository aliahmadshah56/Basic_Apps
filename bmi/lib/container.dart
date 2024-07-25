import 'package:flutter/cupertino.dart';

class RepaeatContainer extends StatelessWidget {

  RepaeatContainer({required this.color, this.cardWidget});
  final Color color;
  final Widget? cardWidget;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: cardWidget,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}