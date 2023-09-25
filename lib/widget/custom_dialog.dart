

import 'package:flutter/material.dart';

Future<void> customDialog(BuildContext context, int score){
  return showDialog(context: context, barrierDismissible: false, builder: (BuildContext dialogContext){
    return AlertDialog(

      title: const Text('Fin de la partie'),
      content: Text('votre score est de : $score'),
      actions: [
        ///retour ecran choix difficulty
        TextButton(onPressed: (){Navigator.popUntil(dialogContext,ModalRoute.withName('Difficulty'));}, child: const Text('Change difficulty')),
        ///rejouer
        TextButton(onPressed: (){}, child: const Text('Play again')),
        ///leaderboard
        TextButton(onPressed: (){}, child: const Text('LeaderBoard')),
      ],
    );
  });
}