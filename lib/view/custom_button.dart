
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/widget/carousel.dart';
import 'package:game/widget/customButton.dart';
import 'package:game/widget/data.dart';

import '../database/scoreProvider.dart';
import '../gameController/game_state.dart';



class CustomButtonStyle extends StatefulWidget{
  final ScoreProvider scoreProvider;
  final GameState state;
  const CustomButtonStyle({super.key, required this.scoreProvider, required this.state});
  @override
  State<CustomButtonStyle> createState() => _CustomButtonStyle();
}
class _CustomButtonStyle extends State<CustomButtonStyle>{

  late  ValueNotifier value ;
  void _onValueChange(dynamic v){
    value.value = v;
    setState(() {

    });
  }

  @override
  void initState(){
    super.initState();
    value = ValueNotifier<dynamic>(StyleButton.classic);
  }

  @override
  Widget build(BuildContext context){
    return   Carousel(
        onSelectedItemChange: _onValueChange,
        list: StyleButton.values.map((e) => e).toList(),
        backButton: createButton(style: value.value, str: 'back', alignment : Alignment.centerLeft, color: const Color(0xff808080), font_color: widget.state.color_font_button, action: (){ context.read<GameCubit>().updateStyleButton(value.value); context.read<GameCubit>().custom();}),
        child: ButtonStyle(styleButton : value.value, color: widget.state.color_button, isLightFont: widget.state.color_font_button,),
    );
  }
}

class ButtonStyle extends StatelessWidget{
  final StyleButton styleButton;
  final Color color;
  final bool isLightFont;
  const ButtonStyle({super.key, required this.styleButton, required this.color, required this.isLightFont});


  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center, child: createButton(style: styleButton, str: styleButton.name, alignment : Alignment.center, color: color , font_color: isLightFont,action: (){},));


  }

}


