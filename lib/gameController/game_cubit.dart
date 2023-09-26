

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

}