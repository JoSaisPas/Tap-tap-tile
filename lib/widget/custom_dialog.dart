

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/gameController/game_state.dart';

Dialog myDialog(BuildContext context, GameState state){
  return Dialog(
    child: Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Fin de la partie'),
          Text('Votre score est de ${state.score}'),
          ///retour ecran choix difficulty
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){context.read<GameCubit>().chooseDifficulty();}, child: const Text('Change difficulty')),
              ///rejouer
              TextButton(onPressed: (){context.read<GameCubit>().game(state.difficulty);}, child: const Text('Play again')),
              ///leaderboard
              TextButton(onPressed: (){}, child: const Text('LeaderBoard')),
            ],
          )
        ],
      ),
    )
  );
}

