import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/gameController/game_state.dart';
import 'package:game/view/custom.dart';
import 'package:game/view/difficulty.dart';
import 'package:game/view/home.dart';
import 'package:game/widget/custom_dialog.dart';

import 'package:game/widget/gameManager.dart';


/**
 * Gestion des thèmes
 *    Tile
 *      : color picker
 *      : apparence
 *
*    Background
 *      : color picker
 *      : aniamted background
 *  Gestion de la sauvegarde
 *    */
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(

      home: BlocProvider(
        create: (_) => GameCubit(),
        child: BlocConsumer<GameCubit, GameState>(
          listener: (context, state){},
          builder: (context, state){

            switch (state.status){
              case GameStatus.initial:
                return const Home();
              case GameStatus.custom:
                return Custom();
              case GameStatus.game_setting:
                return const DifficultyPage();
              case GameStatus.game:
                return GameManager(dif: state.difficulty, color: state.color,);
              case GameStatus.finish:
                return myDialog(context, state,);
              case GameStatus.quit:
                return  exit(0);
            }
          },
        ),
      ),
    );
  }
}