import 'package:flutter/material.dart';
import 'package:game/widget/corridor.dart';
import 'package:game/widget/data.dart';
import 'package:game/widget/gameManager.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
           // child: Corridor(dif: Difficulty.hight)),
            child: GameManager(dif: Difficulty.middle)),
      ),
    );
  }
}