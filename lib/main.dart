import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void playMusic(int noteNumber) {
    final player = AudioPlayer();
    player.play(AssetSource('sounds/note$noteNumber.wav'));
  }

  final list = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple
  ];
  Expanded buildKey(int soundNumber) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: list[soundNumber - 1]),
        onPressed: () {
          playMusic(soundNumber);
        },
        child: Container(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Xylophone App'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return buildKey(index + 1);
          },
        ));
  }
}
