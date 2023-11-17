import 'dart:ui';
import 'package:flutter/material.dart';
import 'data.dart';


TextStyle textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
Widget createButton({required StyleButton style, required String str, required Alignment alignment, required Function action, required Color color, required bool font_color}){
  switch(style){
    case StyleButton.glass:
      return CustomGlassButton(str: str, alignment: alignment, action: action, color: color, font_color: font_color,);
    case StyleButton.classic:
      return CustomClassicButton(str: str, alignment: alignment, action: action, color: color, font_color: font_color);
    case StyleButton.neon:
      return CustomNeonButton(str: str, alignment: alignment, action: action, color: color, font_color: font_color);
  }
}

class CustomClassicButton extends StatelessWidget{
  final String str;
  final Alignment alignment;
  final Function action;
  final Color color;
  final bool font_color;
  const CustomClassicButton({super.key, required this.str, required this.alignment, required this.action, required this.color, required this.font_color});

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: alignment,
      child: InkWell(
        onTap: (){
          action();
        },
        child: Container(
          color: color,
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.width * .1,
          child: Center(child: Text(str, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: font_color ? Colors.white : Colors.black),),),
        ),
      ),
    );
  }
}


const blur = 5.0;
class CustomGlassButton extends StatelessWidget{
  final String str;
  final Alignment alignment;
  final Function action;
  final Color color;
  final bool font_color;
  const CustomGlassButton({super.key, required this.str, required this.alignment, required this.action, required this.color, required this.font_color});

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: alignment,
      child: InkWell(
        onTap: (){
          action();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.width * .1,
          color: color.withOpacity(0.5),
         child: ClipRRect(
           child: BackdropFilter(
             filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
             child: Center(child: Text(str,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: font_color? Colors.white : Colors.black)),),
           ),
         ),
        ),
      ),
    );
  }
}

class CustomNeonButton extends StatelessWidget{
  final String str;
  final Alignment alignment;
  final Function action;
  final Color color;
  final bool font_color;

  const CustomNeonButton(
      {super.key,
      required this.str,
      required this.alignment,
      required this.action,
      required this.color,
      required this.font_color});

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: alignment,
      child: InkWell(
        onTap: (){
          action();
        },
        child: Container(

          decoration:  BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(5),
              //color: color,
            boxShadow:
            [
              // ///inner shadow
              BoxShadow( spreadRadius:  -1, color: color, blurRadius: 12, blurStyle: BlurStyle.outer),
              BoxShadow( spreadRadius:  -3, color: color, blurRadius: 14, blurStyle: BlurStyle.outer),
              BoxShadow( spreadRadius:  -5, color: color, blurRadius: 16, blurStyle: BlurStyle.outer),
              BoxShadow( spreadRadius:  -5, color: color, blurRadius: 16, blurStyle: BlurStyle.outer),

              ///outer shadow
              BoxShadow( spreadRadius:  0, color: color, blurRadius: 5, blurStyle: BlurStyle.outer),
              BoxShadow( spreadRadius:  0, color: color, blurRadius: 8, blurStyle: BlurStyle.outer),
              BoxShadow( spreadRadius:  0, color: color, blurRadius: 11, blurStyle: BlurStyle.outer),

            ]
          ),
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.width * .1,
          child: Center(child: Text(str, style:
          TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: font_color ? Colors.white : Colors.black,
            shadows: [
              Shadow(color: color.withOpacity(0.9), blurRadius: 20, offset: const Offset(0.0, 0.0))
            ]
          ),),),
        ),
      ),
    );
  }
}