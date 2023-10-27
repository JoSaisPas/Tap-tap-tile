import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/gameController/game_state.dart';

import '../widget/customButton.dart';
import '../widget/data.dart';

class DifficultyPage extends StatelessWidget{
  final GameState state;
  const DifficultyPage({super.key, required this.state});


  @override
  Widget build(BuildContext context){
    return   Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          createButton(style: state.styleButton, str: '3 X 3', alignment : Alignment.centerRight, action: () {context.read<GameCubit>().game(Difficulty.easy);},),
          createButton(style: state.styleButton,str: '4 X 4', alignment : Alignment.centerLeft,  action: () {context.read<GameCubit>().game(Difficulty.middle);},),
          createButton(style: state.styleButton,str: '5 X 5', alignment : Alignment.centerRight,  action: () {context.read<GameCubit>().game(Difficulty.hight);},),
          createButton(style: state.styleButton,str: 'Back', alignment : Alignment.centerLeft, action: () => {context.read<GameCubit>().home()}),
        ],

    );
  }
}