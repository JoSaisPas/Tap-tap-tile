
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/widget/carousel.dart';
import 'package:game/widget/customButton.dart';
import 'package:game/widget/data.dart';

import '../database/scoreProvider.dart';
import '../gameController/game_state.dart';



class CustomButtonColor extends StatefulWidget{
  final ScoreProvider scoreProvider;
  final GameState state;
  const CustomButtonColor({super.key, required this.scoreProvider, required this.state});
  @override
  State<CustomButtonColor> createState() => _CustomButtonColor();
}
class _CustomButtonColor extends State<CustomButtonColor>{

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
      backButton: createButton(style: widget.state.styleButton, str: 'back', alignment : Alignment.centerLeft, color: const Color(0xff808080),font_color: widget.state.color_font_button, action: (){ context.read<GameCubit>().updateColorButton(value.value); context.read<GameCubit>().custom();}),
      child: ButtonStyle(styleButton : widget.state.styleButton, color: value.value, lightFont: widget.state.color_font_button,),
    );
  }
}

class ButtonStyle extends StatelessWidget{
  final Color color;
  final StyleButton styleButton;
  final bool lightFont;
  const ButtonStyle({super.key, required this.styleButton, required this.color, required this.lightFont});


  @override
  Widget build(BuildContext context) {
    //return Align(alignment: Alignment.center, child: createButton(style: styleButton, str: styleButton.name, alignment : Alignment.center,color: color, action: (){},));
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Color font', style: TextStyle(fontSize: 25),),

          Slider(
          divisions: 1,
          inactiveColor: Colors.black,
          activeColor: Colors.grey,
          thumbColor: Colors.red,
          value:  lightFont ? 0.0 : 1.0,
          onChanged: (value){
            context.read<GameCubit>().updateColorFontButton(value == 0.0 ? true : false);
          }
      ),
          Align(alignment: Alignment.center, child: createButton(style: styleButton, str: styleButton.name, alignment : Alignment.center,color: color,font_color: lightFont, action: (){},)),
        ],
      );
  }

}




