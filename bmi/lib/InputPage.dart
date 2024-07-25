import 'package:flutter/material.dart';


class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RepaeatContainer(
                      color: Color(0xFF1D1E33),
                       cardWidget:  columnWidget(ico: Icons.male, txt: 'MALE',),
                  ),
                ),
                Expanded(
                  child: RepaeatContainer(
                      color: Color(0xFF1D1E33),
                    cardWidget:  columnWidget(ico: Icons.female,txt: "FEMALE",),
                  ),

                ),
              ],
            ),
          ),

          Expanded(
              child: new RepaeatContainer(
                  color: Color(0xFF1D1E33),
              )
          ),
          Expanded(
            child: Row(
            children: [
              Expanded(
                  child: new RepaeatContainer(
                      color: Color(0xFF1D1E33),
                    )
            ),
              Expanded(
                  child:new RepaeatContainer(color: Color(0xFF1D1E33))
              ),


            ],
          ),),
        ],
      )
    );
  }
}

class columnWidget extends StatelessWidget {
 final String txt;
 final IconData ico;

 columnWidget({required this.txt, required this.ico});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          ico,
          size: 100,
        ),
      SizedBox(height: 10,),
      Text(txt,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),)],
    );
  }
}

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