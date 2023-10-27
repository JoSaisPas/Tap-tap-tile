

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_state.dart';

import '../gameController/game_cubit.dart';
import '../widget/customButton.dart';

class Custom extends StatelessWidget{
  final GameState state;
  const Custom({super.key, required this.state});

  @override
  Widget build(BuildContext context){
    return  Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          createButton(style: state.styleButton, str: 'Color tile', alignment : Alignment.centerLeft, color: state.color_button, font_color: state.color_font_button, action: () => {context.read<GameCubit>().customTile()}),
          createButton(style: state.styleButton, str: 'Button style', alignment : Alignment.centerRight, color: state.color_button, font_color: state.color_font_button,action: () => {context.read<GameCubit>().customButtonStyle()}),
          createButton(style: state.styleButton, str: 'Button color', alignment : Alignment.centerLeft, color: state.color_button, font_color: state.color_font_button,action: () => {context.read<GameCubit>().customButtonColor()}),
          createButton(style: state.styleButton, str: 'Background style', alignment : Alignment.centerRight,  color: state.color_button,font_color: state.color_font_button,action: () => {context.read<GameCubit>().customBackground()}),
          createButton(style: state.styleButton, str: 'Back', alignment : Alignment.centerLeft, color: state.color_button, font_color: state.color_font_button,action: () => {context.read<GameCubit>().home()}),
        ],
    );
  }
}
