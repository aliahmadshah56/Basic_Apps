import 'package:flutter/material.dart';

class RepaeatContainer extends StatelessWidget {
  final Color color;
  final Widget cardWidget;

  const RepaeatContainer({required this.color, required this.cardWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: cardWidget,
    );
  }
}

