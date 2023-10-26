import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/animated_background/models.dart';
import 'package:game/animated_background/multiple_particules.dart';
import 'package:game/database/scoreProvider.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/gameController/game_state.dart';
import 'package:game/view/custom.dart';
import 'package:game/view/custom_background.dart';
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
  runApp(
      BlocProvider(create: (_) => GameCubit(),
        child: const MyApp(),),
  );
}

Modele modele = ParticuleBubbles();

class MyApp extends StatefulWidget{
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyApp();
}
class _MyApp extends State<MyApp> with TickerProviderStateMixin{


  @override
  Widget build(BuildContext context){
    return BlocBuilder<GameCubit, GameState>(
        builder: (context, state){
          return MaterialApp(
            theme: state.lightTheme ?
            ThemeData.light() : ThemeData.dark(),
            home: Scaffold(
              body: MultipleParticules(
                modele: state.model,
                vsync: this,
                child:  BlocConsumer<GameCubit, GameState>(
                  listener: (context, state){},
                  builder: (context, state){
                    switch (state.status){
                      case GameStatus.initial:
                        return  Home(state: state,);
                      case GameStatus.custom:
                        return Custom(state: state,);
                      case GameStatus.custom_tile:
                        return CustomTile(scoreProvider: scoreProvider, state: state);
                      case GameStatus.custom_button:
                        return CustomButton(scoreProvider: scoreProvider, state: state);
                      case GameStatus.custom_background:
                        return CustomBackground(scoreProvider: scoreProvider, state: state);
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
            ),

          );
        });
  }
}