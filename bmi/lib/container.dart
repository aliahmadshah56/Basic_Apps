import 'package:flutter/cupertino.dart';

class RepaeatContainer extends StatelessWidget {
  RepaeatContainer({required this.color, this.cardWidget, this.onPressed});

  final Color color;
  final Widget? cardWidget;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed!();
      },
      child: Container(
        margin: EdgeInsets.all(15),
        child: cardWidget,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
