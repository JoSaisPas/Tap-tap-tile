

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_state.dart';

import '../gameController/game_cubit.dart';
import '../widget/customButton.dart';

class Custom extends StatelessWidget{
  final GameState state;
  const Custom({super.key, required this.state});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          createButton(style: state.styleButton, str: 'Color tile', isRight : false, action: () => {context.read<GameCubit>().customTile()}),
          createButton(style: state.styleButton, str: 'Button style', isRight : true,  action: () => {context.read<GameCubit>().customButton()}),
          createButton(style: state.styleButton, str: 'Back', isRight : false, action: () => {context.read<GameCubit>().home()}),
        ],
      ),
    );
  }
}
