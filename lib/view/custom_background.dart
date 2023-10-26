
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
      appBar: AppBar(
        leading: InkWell(
          onTap: (){ context.read<GameCubit>().updateBackgroundStyle(value.value); context.read<GameCubit>().custom();},
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text('Back'),
        actions: [
          Row(
            children: [
              Text('Theme'),
              Slider(
                divisions: 1,
                inactiveColor: Colors.black,
                  activeColor: Colors.white,
                  thumbColor: widget.state.lightTheme ? Colors.white : Colors.black,
                  value: widget.state.lightTheme ? 0.0 : 1.0,
                  onChanged: (value){
                    context.read<GameCubit>().updateTheme(value == 0.0 ? true : false);
                  }
              ),
            ],
          )

        ],
      ),
      body:  Carousel(
        onSelectedItemChange: _onValueChange,
        list: BackgroundStyle.values.map((e) => e).toList(),
        child: ButtonStyle(modele: getModel(value.value), ticker: this,),
      ),
    );
  }
}

///Best way ??
class ButtonStyle extends StatelessWidget{
  final Modele modele;
  final TickerProvider ticker;
  const ButtonStyle({super.key, required this.modele, required this.ticker});

  @override
  Widget build(BuildContext context) {
    return  MultipleParticules(modele: modele, vsync: ticker,child: Container(),);
  }
}


