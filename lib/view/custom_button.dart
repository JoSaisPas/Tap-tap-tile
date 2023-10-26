
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/widget/carousel.dart';
import 'package:game/widget/customButton.dart';
import 'package:game/widget/data.dart';

import '../database/scoreProvider.dart';
import '../gameController/game_state.dart';



class CustomButton extends StatefulWidget{
  final ScoreProvider scoreProvider;
  final GameState state;
  const CustomButton({super.key, required this.scoreProvider, required this.state});
  @override
  State<CustomButton> createState() => _CustomButton();
}
class _CustomButton extends State<CustomButton>{

  late  ValueNotifier value ;
  void _onValueChange(dynamic v){
    value.value = v;
    setState(() {

    });
  }

  @override
  void initState(){
    super.initState();
    value = ValueNotifier<dynamic>(widget.state.styleButton);
  }

  @override
  Widget build(BuildContext context){
    return   Carousel(
        onSelectedItemChange: _onValueChange,
        list: StyleButton.values.map((e) => e).toList(),
        backButton: createButton(style: value.value, str: 'back', isRight: false, action: (){ context.read<GameCubit>().updateStyleButton(value.value); context.read<GameCubit>().custom();}),
        child: ButtonStyle(styleButton : value.value,),
    );
  }
}

class ButtonStyle extends StatelessWidget{
  final StyleButton styleButton;

  const ButtonStyle({super.key, required this.styleButton});


  @override
  Widget build(BuildContext context) {
    return Stack(
       children: [
         //const Align(alignment: Alignment.center, child: FlutterLogo(size: 200,),),
         createButton(style: styleButton, str: styleButton.name, isRight: false, action: (){},),
       ],
    );
  }

}


