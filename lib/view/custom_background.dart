
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/animated_background/models.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/widget/carousel.dart';
import 'package:game/widget/customButton.dart';
import 'package:game/widget/data.dart';

import '../animated_background/multiple_particules.dart';
import '../database/scoreProvider.dart';
import '../gameController/game_state.dart';



class CustomBackground extends StatefulWidget{
  final ScoreProvider scoreProvider;
  final GameState state;
  const CustomBackground({super.key, required this.scoreProvider, required this.state});
  @override
  State<CustomBackground> createState() => _CustomBackground();
}
class _CustomBackground extends State<CustomBackground> with TickerProviderStateMixin{

  late  ValueNotifier value ;
  void _onValueChange(dynamic v){
    value.value = v;
    setState(() {

    });
  }

  @override
  void initState(){
    super.initState();
    value = ValueNotifier<dynamic>(BackgroundStyle.classic);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:  Carousel(
        onSelectedItemChange: _onValueChange,
        list: BackgroundStyle.values.map((e) => e).toList(),
        backButton: createButton(style: widget.state.styleButton, str: 'back', alignment : Alignment.centerLeft,color: const Color(0xff808080), font_color: widget.state.color_font_button, action: (){ context.read<GameCubit>().updateBackgroundStyle(value.value); context.read<GameCubit>().custom();}),
        child: ButtonStyle(state: widget.state, ticker: this, modele: getModel(value.value),),

      ),
    );
  }
}


class ButtonStyle extends StatelessWidget{
   final Modele modele;
   final TickerProvider ticker;
  final GameState state;
  const ButtonStyle({
    super.key,
     required this.modele,
     required this.ticker,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return

    MultipleParticules(modele: modele, vsync: ticker,child: SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Theme', style: TextStyle(fontSize: 25),),
          Slider(
              divisions: 1,
              inactiveColor: Colors.black,
              activeColor: Colors.white,
              thumbColor: Colors.red,
              value: state.lightTheme ? 0.0 : 1.0,
              onChanged: (value){
                context.read<GameCubit>().updateTheme(value == 0.0 ? true : false);
              }
          ),
        ],
      ),
    ),);

    //
  }
}


