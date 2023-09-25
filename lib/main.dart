import 'package:flutter/material.dart';
import 'package:game/view/home.dart';

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
    home: Home(),
      // Scaffold(
      //   backgroundColor: Colors.grey,
      //   body: Center(
      //       child: GameManager(dif: Difficulty.middle)),
      // ),
    );
  }
}