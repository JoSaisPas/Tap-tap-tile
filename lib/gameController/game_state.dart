
import 'dart:ui';

import 'package:equatable/equatable.dart';

import '../widget/data.dart';

/**
 * initial : home page
 * dif_choosen : difficulty page
 * game : game page
 * finish : fin de partie donc popup
 * */
enum GameStatus {initial, game_setting, game, finish, quit, custom}

class GameState extends Equatable {

  GameState({this.status = GameStatus.initial, this.difficulty = Difficulty.easy, this.score = 0, this.color = const Color(0xff000000),});
  GameStatus status;
  Difficulty difficulty;
  int score;
  Color color;

  GameState copyWith({
    GameStatus? status,
    Difficulty? difficulty,
    int? score,
    Color? color,
  }){
    return GameState(status: status ?? this.status, difficulty: difficulty ?? this.difficulty, score: score ?? this.score, color: color ?? this.color);
  }

  @override
  List<Object?> get props => [status, difficulty, score, color];

}