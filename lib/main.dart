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
  final list = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple
  ];

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
            final keyindex = index;
            return ColorKey(list: list, keyindex: keyindex);
          },
        ));
  }
}

class ColorKey extends StatelessWidget {
  const ColorKey({
    Key? key,
    required this.list,
    required this.keyindex,
  }) : super(key: key);

  final List<MaterialColor> list;
  final int keyindex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: list[keyindex]),
        onPressed: () {
          playMusic(keyindex + 1);
        },
        child: Container(),
      ),
    );
  }
}

void playMusic(int noteNumber) {
  final player = AudioPlayer();
  player.play(AssetSource('sounds/note$noteNumber.wav'));
}
