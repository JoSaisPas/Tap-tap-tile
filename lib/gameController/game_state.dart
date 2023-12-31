
import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:game/animated_background/models.dart';
import '../database/options.dart';
import '../widget/data.dart';
import 'package:path/path.dart';

  ///Quit long, maybe refactor later !
enum GameStatus {
  initial,
  game_setting,
  game,
  finish,
  quit,
  custom,
  leaderboard,
  custom_tile,
  custom_button_style,
  custom_background,
  custom_button_color,
}

class GameState extends Equatable {


  GameState({
    GameStatus? status,
    Difficulty? difficulty,
    Color? color_tile,
    int? score,
    StyleButton? styleButton,
    Modele? model,
    bool? lightTheme,
    Color? color_button,
    bool? color_font_button,
  }):
    this.status = status ?? GameStatus.initial,
    this.difficulty = difficulty ?? Difficulty.easy,
    this.score = score ?? 0,
    this.color_tile = color_tile ?? const Color(0xff000000),
    this.styleButton = styleButton ?? StyleButton.glass,
    this.model =  model ?? ParticuleEmpty(),
    this.lightTheme = lightTheme ?? true,
    this.color_button = color_button ?? const Color(0xff808080),
    this.color_font_button = color_font_button ?? false;


  GameStatus status;
  Difficulty difficulty;
  int score;
  Color color_tile;
  StyleButton styleButton;
  Modele model;
  bool lightTheme;
  Color color_button;
  bool color_font_button;


  GameState copyWith({
    GameStatus? status,
    Difficulty? difficulty,
    int? score,
    Color? color_tile,
    StyleButton? styleButton,
    Modele? model,
    bool? lightTheme,
    Color? color_button,
    bool? color_font_button,
  }){
    return GameState(
        status: status ?? this.status,
        difficulty: difficulty ?? this.difficulty,
        score: score ?? this.score,
        color_tile: color_tile ?? this.color_tile,
        styleButton: styleButton ?? this.styleButton,
        model: model ?? this.model,
      lightTheme: lightTheme ?? this.lightTheme,
      color_button: color_button ?? this.color_button,
      color_font_button: color_font_button ?? this.color_font_button,
    );
  }

  @override
  List<Object?> get props => [status, difficulty, score, color_tile, styleButton, model, lightTheme, color_button, color_font_button];

}