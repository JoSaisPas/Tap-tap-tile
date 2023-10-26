import 'dart:ui';

import 'package:flutter/material.dart';

import 'data.dart';
Widget createButton({required StyleButton style, required String str, required bool isRight, required Function action}){
  switch(style){
    case StyleButton.glass:
      return CustomGlassButton(str: str, isRight: isRight, action: action);
    case StyleButton.classic:
      return CustomButton(str: str, isRight: isRight, action: action);
  }
}

class CustomButton extends StatelessWidget{
  final String str;
  final bool isRight;
  final Function action;
  const CustomButton({super.key, required this.str, required this.isRight, required this.action});


  @override
  Widget build(BuildContext context){
    return Align(
      alignment: isRight ? const Alignment(-1, 0) : const Alignment(1, 0),
      child: InkWell(
        onTap: (){
          action();
        },
        child: Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.width * .1,
          child: Center(child: Text(str),),
        ),
      ),
    );
  }
}


const blur = 5.0;
class CustomGlassButton extends StatelessWidget{
  final String str;
  final bool isRight;
  final Function action;

  const CustomGlassButton({super.key, required this.str, required this.isRight, required this.action});


  @override
  Widget build(BuildContext context){
    return Align(
      alignment: isRight ? const Alignment(-1, 0) : const Alignment(1, 0),
      child: InkWell(
        onTap: (){
          action();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.width * .1,
          color: Colors.grey.withOpacity(0.5),
         child: ClipRRect(
           child: BackdropFilter(
             filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
             child: Container(
               child: Center(child: Text(str),),
             ),
           ),
         ),
        ),
      ),
    );
  }
}