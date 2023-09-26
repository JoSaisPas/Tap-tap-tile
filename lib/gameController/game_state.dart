
import 'package:equatable/equatable.dart';

import '../widget/data.dart';

/**
 * initial : home page
 * dif_choosen : difficulty page
 * game : game page
 * finish : fin de partie donc popup
 * */
enum GameStatus {initial, game_setting, game, finish, quit}

class GameState extends Equatable {

  GameState({this.status = GameStatus.finish, this.difficulty = Difficulty.easy, this.score = 0});
  GameStatus status;
  Difficulty difficulty;
  int score;

  GameState copyWith({
    GameStatus? status,
    Difficulty? difficulty,
    int? score,
  }){
    return GameState(status: status ?? this.status, difficulty: difficulty ?? this.difficulty, score: score ?? this.score);
  }

  @override
  List<Object?> get props => [status, difficulty, score];

}