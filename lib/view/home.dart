
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/gameController/game_state.dart';

import '../widget/customButton.dart';

class Home extends StatelessWidget{
  final GameState state;
  const Home({super.key, required this.state});


  @override
  Widget build(BuildContext context){
    return   Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Tap Tap tile', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),

          createButton(style: state.styleButton, str: 'Play', alignment : Alignment.centerRight, color: state.color_button, font_color: state.color_font_button,action: (){context.read<GameCubit>().chooseDifficulty();},),
          createButton(style: state.styleButton, str: 'Custom', alignment : Alignment.centerLeft, color: state.color_button, font_color: state.color_font_button,action: (){context.read<GameCubit>().custom();},),
          createButton(style: state.styleButton, str: 'LeaderBoard', alignment : Alignment.centerRight,color: state.color_button, font_color: state.color_font_button, action: (){context.read<GameCubit>().leaderBoard();},),
          createButton(style: state.styleButton, str: 'Quit', alignment : Alignment.centerLeft, color: state.color_button, font_color: state.color_font_button,action: () => {context.read<GameCubit>().quit()},),
        ],

    );
  }
}

