import 'dart:io';

import 'package:flutter/material.dart';
import 'package:game/view/difficulty.dart';

import '../widget/customButton.dart';

class Home extends StatelessWidget{
  const Home({super.key});


  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          ///Title
          const Text('Tap Tap tile'),
          CustomButton(str: 'Play', isRight: false, push: () => Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: 'Difficulty'), builder: (context) => const DifficultyPage())),),
          CustomButton(str: 'Custom', isRight: true, push: (){},),
          CustomButton(str: 'Quit', isRight: false, push: () => exit(0),),
          ///Play
          ///Custom
          ///Quite
        ],
      ),
    );
  }
}

