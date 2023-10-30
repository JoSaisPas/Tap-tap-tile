

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/database/options.dart';
import 'package:game/gameController/game_state.dart';

import '../gameController/game_cubit.dart';
import '../widget/customButton.dart';
import '../widget/data.dart';

class Custom extends StatelessWidget{
  final GameState state;
  final OptionsProvider optionsProvider;
  const Custom({super.key, required this.state, required this.optionsProvider});

  @override
  Widget build(BuildContext context){
    return  Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          createButton(style: state.styleButton, str: 'Color tile', alignment : Alignment.centerLeft, color: state.color_button, font_color: state.color_font_button, action: () => {context.read<GameCubit>().customTile()}),
          createButton(style: state.styleButton, str: 'Style button', alignment : Alignment.centerRight, color: state.color_button, font_color: state.color_font_button,action: () => {context.read<GameCubit>().customButtonStyle()}),
          createButton(style: state.styleButton, str: 'Color button', alignment : Alignment.centerLeft, color: state.color_button, font_color: state.color_font_button,action: () => {context.read<GameCubit>().customButtonColor()}),
          createButton(style: state.styleButton, str: 'Background', alignment : Alignment.centerRight,  color: state.color_button,font_color: state.color_font_button,action: () => {context.read<GameCubit>().customBackground()}),
          createButton(style: state.styleButton, str: 'Back', alignment : Alignment.centerLeft, color: state.color_button, font_color: state.color_font_button,
              action: ()  async {
            context.read<GameCubit>().home();

            Options opt = Options(
                color_tile: state.color_button,
                button_style: state.styleButton,
                model: getBackgroundStyle(state.model),
                theme: state.lightTheme,
                button_color: state.color_button,
                button_color_font: state.color_font_button
            );

                if(await optionsProvider.getOptionFromId(1) != null){
                    optionsProvider.update(opt,1);
                }else{
                  optionsProvider.insert(opt);
                }

          }),
        ],
    );
  }
}
