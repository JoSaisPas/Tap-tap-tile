

import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_state.dart';
import 'package:game/widget/data.dart';

class GameCubit extends Cubit<GameState>{

  GameCubit():super(GameState());

  ///Difficulty view
 void chooseDifficulty(){
   emit(state.copyWith(status: GameStatus.game_setting));
 }

  ///Game view
  void game(Difficulty difficulty){
    emit(state.copyWith(status: GameStatus.game, difficulty: difficulty));
  }

  ///Finish (pop up) view
  void finish(int score){
    emit(state.copyWith(status: GameStatus.finish, score: score));
  }

  ///Home view
  void home(){
    emit(state.copyWith(status: GameStatus.initial));
  }

  ///Quit 'view'
  void quit(){
    emit(state.copyWith(status: GameStatus.quit));
  }

  ///Custom view
  void custom(){
    emit(state.copyWith(status: GameStatus.custom));
  }

  void updateColor(Color color){
   print('changing color ${state.color} to ${color}');
   emit(state.copyWith(color: color));
  }

  void updateStyleButton(StyleButton styleButton){
    print('changing style button ${state.styleButton} to ${styleButton}');
    emit(state.copyWith(styleButton: styleButton));
  }

  void updateBackgroundStyle(BackgroundStyle style){
   print(style);
    print('changing style background ${state.model} to ${style}');
    emit(state.copyWith(model: getModel(style)));
  }

  void updateTheme(bool theme){
    print('changing theme ${state.lightTheme} to ${theme}');
    emit(state.copyWith(lightTheme: theme));
  }

  ///LeaderView view
  void leaderBoard(){
    emit(state.copyWith(status: GameStatus.leaderboard));
  }

  ///Tile color view
  void customTile(){
    emit(state.copyWith(status: GameStatus.custom_tile));
  }

  ///Button style view
  void customButton(){
    emit(state.copyWith(status: GameStatus.custom_button));
  }

  ///Button style view
  void customBackground(){
    emit(state.copyWith(status: GameStatus.custom_background));
  }

}