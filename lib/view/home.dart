
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/gameController/game_state.dart';
import 'package:game/widget/data.dart';

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
          const Text('Tap Tap tile'),

          createButton(style: state.styleButton, str: 'Play', isRight: false, action: (){context.read<GameCubit>().chooseDifficulty();},),
          createButton(style: state.styleButton, str: 'Custom', isRight: true, action: (){context.read<GameCubit>().custom();},),
          createButton(style: state.styleButton, str: 'LeaderBoard', isRight: false, action: (){context.read<GameCubit>().leaderBoard();},),
          createButton(style: state.styleButton, str: 'Quit', isRight: true, action: () => {context.read<GameCubit>().quit()},),
        ],

    );
  }
}

