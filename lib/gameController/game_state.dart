
import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:game/animated_background/models.dart';
import '../widget/data.dart';


enum GameStatus {initial, game_setting, game, finish, quit, custom, leaderboard, custom_tile, custom_button, custom_background}

class GameState extends Equatable {

  GameState({
    this.status = GameStatus.initial,
    this.difficulty = Difficulty.easy,
    this.score = 0,
    this.color = const Color(0xff000000),
    this.styleButton = StyleButton.classic,
    Modele? model,
    this.lightTheme = true,
  }): this.model =  model ?? ParticuleBubbles();
  GameStatus status;
  Difficulty difficulty;
  int score;
  Color color;
  StyleButton styleButton;
  Modele model;
  bool lightTheme;

  GameState copyWith({
    GameStatus? status,
    Difficulty? difficulty,
    int? score,
    Color? color,
    StyleButton? styleButton,
    Modele? model,
    bool? lightTheme,
  }){
    return GameState(
        status: status ?? this.status,
        difficulty: difficulty ?? this.difficulty,
        score: score ?? this.score,
        color: color ?? this.color,
        styleButton: styleButton ?? this.styleButton,
        model: model ?? this.model,
      lightTheme: lightTheme ?? this.lightTheme,
    );
  }

  @override
  List<Object?> get props => [status, difficulty, score, color, styleButton, model, lightTheme];

}