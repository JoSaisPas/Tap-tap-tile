import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/database/scoreProvider.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/gameController/game_state.dart';
import 'package:game/view/custom.dart';
import 'package:game/view/custom_button.dart';
import 'package:game/view/custom_tile.dart';
import 'package:game/view/difficulty.dart';
import 'package:game/view/home.dart';
import 'package:game/view/leaderboard.dart';
import 'package:game/widget/custom_dialog.dart';

import 'package:game/widget/gameManager.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



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
ScoreProvider scoreProvider = ScoreProvider();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  scoreProvider.open(join( await getDatabasesPath(), 'tap_tap_tile_database.db'));
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
                return  Home(state: state,);
               // return  Stack(children: [Background(), Home()],);
              case GameStatus.custom:
                return Custom(state: state,);
              case GameStatus.custom_tile:
              return CustomTile(scoreProvider: scoreProvider, state: state);
              case GameStatus.custom_button:
              return CustomButton(scoreProvider: scoreProvider, state: state);
              case GameStatus.game_setting:
                return  DifficultyPage(state: state,);
              case GameStatus.game:
                return GameManager(dif: state.difficulty, color: state.color,);
              case GameStatus.finish:
                return testFuture(state: state, scoreProvider: scoreProvider);
              case GameStatus.leaderboard:
                return   LeaderBoard(scoreProvider: scoreProvider, state: state,);
              case GameStatus.quit:
                return  exit(0);
            }
          },
        ),
      ),
    );
  }
}