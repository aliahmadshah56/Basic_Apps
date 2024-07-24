import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('XyloPhone'),
          ),
          body: Xylo(),
        ));
  }
}

class Xylo extends StatefulWidget {
  const Xylo({super.key});

  @override
  State<Xylo> createState() => _XyloState();
}

class _XyloState extends State<Xylo> {
  void PlaySound(int num) {
    AssetsAudioPlayer.newPlayer().open(
      Audio('asserts/note$num.wav'),
    );
  }

  Expanded CreateNewButton({int sound=1, Color colur=Colors.black26,String s=''}) {
    return Expanded(
        child: (Container(
          color: colur,
          child: TextButton(
            onPressed: () {
              PlaySound(sound);
            },
            child: Text('$s'),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CreateNewButton(sound: 3),
        CreateNewButton(colur: Colors.grey,sound: 7,s: 'Ali'),
        CreateNewButton(sound: 2),
        CreateNewButton(s: 'Ahmad',colur: Colors.black12),
        CreateNewButton(sound: 4),
        CreateNewButton(sound:5,s: 'Shah',colur: Colors.white),
        CreateNewButton(sound:6,),
      ],
    );
  }


}
