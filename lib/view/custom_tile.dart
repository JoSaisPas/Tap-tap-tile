
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/widget/carousel.dart';

import '../database/scoreProvider.dart';
import '../gameController/game_state.dart';
import '../widget/customButton.dart';
import '../widget/data.dart';


class CustomTile extends StatefulWidget{
  final ScoreProvider scoreProvider;
  final GameState state;
  const CustomTile({super.key, required this.scoreProvider, required this.state});
  @override
  State<CustomTile> createState() => _LeaderBoard();
}
class _LeaderBoard extends State<CustomTile>{


  //ValueNotifier value  = ValueNotifier<dynamic>(widget.state.color);
 late  ValueNotifier value ;
  void _onValueChange(dynamic v){
    value.value = v;
    setState(() {

    });
  }

  @override
  void initState(){
    super.initState();
    value = ValueNotifier<dynamic>(colors[0]);
  }

  @override
  Widget build(BuildContext context){
    return   Carousel(
        onSelectedItemChange: _onValueChange,
        list: colors,
        backButton: createButton(style: widget.state.styleButton, str: 'back', alignment : Alignment.centerLeft, color: widget.state.color_button,font_color: widget.state.color_font_button, action: (){ context.read<GameCubit>().updateColorTile(value.value); context.read<GameCubit>().custom();}),
        child: TileStyle(color: value.value,),
    );
  }
}

class TileStyle extends StatelessWidget{
  final Color color;

  const TileStyle({super.key, required this.color});





  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
        child : Container(
          height: MediaQuery.of(context).size.height * .2,
          width: MediaQuery.of(context).size.width * 0.2,
          color: color,
        )

    );
  }

}


