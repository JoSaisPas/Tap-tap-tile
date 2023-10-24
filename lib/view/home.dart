
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';

import '../widget/customButton.dart';

class Home extends StatelessWidget{
  const Home({super.key});


  @override
  Widget build(BuildContext context){
    return  Scaffold(
      //backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Tap Tap tile'),
          CustomButton(str: 'Play', isRight: false, action: (){context.read<GameCubit>().chooseDifficulty();},),
          CustomButton(str: 'Custom', isRight: true, action: (){context.read<GameCubit>().custom();},),
          CustomButton(str: 'LeaderBoard', isRight: false, action: (){context.read<GameCubit>().leaderBoard();},),
          CustomButton(str: 'Quit', isRight: true, action: () => {context.read<GameCubit>().quit()},),
        ],
      ),
    );
  }
}

