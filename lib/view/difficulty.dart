import 'package:flutter/material.dart';
import 'package:game/widget/gameManager.dart';

import '../widget/customButton.dart';
import '../widget/data.dart';

class DifficultyPage extends StatelessWidget{
  const DifficultyPage({super.key});


  @override
  Widget build(BuildContext context){
    return   Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          
          CustomButton(str: '3 X 3', isRight: false, push: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const GameManager(dif: Difficulty.easy)));},),
          CustomButton(str: '4 X 4', isRight: true,  push: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const GameManager(dif: Difficulty.middle)));},),
          CustomButton(str: '5 X 5', isRight: false,  push: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const GameManager(dif: Difficulty.hight)));},),
          CustomButton(str: 'Back', isRight: true, push: () => {Navigator.pop(context)}),
          ///Play
          ///Custom
          ///Quite
        ],
      ),
    );
  }
}