import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';

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
          CustomButton(str: '3 X 3', isRight: false, action: () {context.read<GameCubit>().game(Difficulty.easy);},),
          CustomButton(str: '4 X 4', isRight: true,  action: () {context.read<GameCubit>().game(Difficulty.middle);},),
          CustomButton(str: '5 X 5', isRight: false,  action: () {context.read<GameCubit>().game(Difficulty.hight);},),
          CustomButton(str: 'Back', isRight: true, action: () => {context.read<GameCubit>().home()}),
        ],
      ),
    );
  }
}