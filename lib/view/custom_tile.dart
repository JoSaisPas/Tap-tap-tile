
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/widget/carousel.dart';

import '../database/scoreProvider.dart';
import '../gameController/game_state.dart';
import '../widget/customButton.dart';
import '../widget/data.dart';


const colors = [

  Color(0xff000000),
  Color(0xff808080),
  Color(0xffC0C0C0),

  Color(0xffFF0000),
  Color(0xffC70039),
  Color(0xffA12626),

  Color(0xffFCF002),
  Color(0xffFCD700),
  Color(0xffFFAA00),

  Color(0xff00FF00),
  Color(0xff49F690),
  Color(0xff25993A),

  Color(0xff0000FF),
  Color(0xff176AF3),
  Color(0xff4EE6DF),
];

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
    value = ValueNotifier<dynamic>(colors[colors.indexOf(widget.state.color)]);
  }

  @override
  Widget build(BuildContext context){
    return   Carousel(
        onSelectedItemChange: _onValueChange,
        list: colors,
        backButton: createButton(style: widget.state.styleButton, str: 'back', alignment : Alignment.centerLeft, action: (){ context.read<GameCubit>().updateColor(value.value); context.read<GameCubit>().custom();}),
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


