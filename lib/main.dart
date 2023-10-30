import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/animated_background/multiple_particules.dart';
import 'package:game/database/options.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/gameController/game_state.dart';
import 'package:game/view/custom.dart';
import 'package:game/view/custom_background.dart';
import 'package:game/view/custom_button.dart';
import 'package:game/view/custom_color_button.dart';
import 'package:game/view/custom_tile.dart';
import 'package:game/view/difficulty.dart';
import 'package:game/view/home.dart';
import 'package:game/view/leaderboard.dart';
import 'package:game/widget/custom_dialog.dart';

import 'package:game/widget/gameManager.dart';
import 'database/app_database.dart';


AppDatabase db = AppDatabase();


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  ///init database and tables
  await db.init();
  ///get options
  Options? options = await db.optionsProvider.getOptionFromId(1);
  runApp(
      BlocProvider(create: (_) => GameCubit(options),
        child: const MyApp(),),
  );
}



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
              resizeToAvoidBottomInset: false,
              body: MultipleParticules(
                modele: state.model,
                vsync: this,
                child:  BlocConsumer<GameCubit, GameState>(
                  listener: (context, state){},
                  builder: (context, state){
                    print(db?.scoreProvider);
                    switch (state.status){
                      case GameStatus.initial:
                        return  Home(state: state,);
                      case GameStatus.custom:
                        return Custom(state: state, optionsProvider: db.optionsProvider);
                      case GameStatus.custom_tile:
                        return CustomTile(scoreProvider: db.scoreProvider, state: state);
                      case GameStatus.custom_button_style:
                        return CustomButtonStyle(scoreProvider: db.scoreProvider, state: state);
                      case GameStatus.custom_button_color:
                        return CustomButtonColor(scoreProvider: db.scoreProvider, state: state);
                      case GameStatus.custom_background:
                        return CustomBackground(scoreProvider: db.scoreProvider, state: state);
                      case GameStatus.game_setting:
                        return  DifficultyPage(state: state,);
                      case GameStatus.game:
                        return GameManager(dif: state.difficulty, color: state.color_tile,);
                      case GameStatus.finish:
                        return FinishDialog(state: state, scoreProvider: db.scoreProvider);
                      case GameStatus.leaderboard:
                        return   LeaderBoard(scoreProvider: db.scoreProvider, state: state,);
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