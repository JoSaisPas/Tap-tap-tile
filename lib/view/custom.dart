

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../gameController/game_cubit.dart';
import '../widget/color_picker.dart';
import '../widget/customButton.dart';

class Custom extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(str: 'Color', isRight: false, action: () => {context.read<GameCubit>().customTile()}),
          CustomButton(str: 'Back', isRight: true, action: () => {context.read<GameCubit>().home()}),
        ],
      ),
    );
  }
}
