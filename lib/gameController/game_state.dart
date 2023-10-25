
import 'dart:ui';
import 'package:equatable/equatable.dart';
import '../widget/data.dart';


enum GameStatus {initial, game_setting, game, finish, quit, custom, leaderboard, custom_tile, custom_button}

class GameState extends Equatable {

  GameState({
    this.status = GameStatus.initial,
    this.difficulty = Difficulty.easy,
    this.score = 0,
    this.color = const Color(0xff000000),
    this.styleButton = StyleButton.classic,
  });
  GameStatus status;
  Difficulty difficulty;
  int score;
  Color color;
  StyleButton styleButton;

  GameState copyWith({
    GameStatus? status,
    Difficulty? difficulty,
    int? score,
    Color? color,
    StyleButton? styleButton,
  }){
    return GameState(
        status: status ?? this.status,
        difficulty: difficulty ?? this.difficulty,
        score: score ?? this.score,
        color: color ?? this.color,
        styleButton: styleButton ?? this.styleButton,
    );
  }

  @override
  List<Object?> get props => [status, difficulty, score, color, styleButton];

}