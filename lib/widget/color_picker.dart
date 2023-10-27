import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';


///Unused

const colors = [
  /**
   * rouge
   * bordeau
   * orange
   * jaune
   * rose
   * bleu claire / ciel
   * bleau azure
   * bleu turquoise
   * bleu nuit
   * vert claire
   * vert foncé
   * marron
   * noir
   * gris
   * */
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

  Color(0xff000000),
  Color(0xff808080),
  Color(0xffC0C0C0),
];
class ColorPicker extends StatefulWidget{
  final Function function;
  const ColorPicker({super.key, required this.function});


  @override
  State<ColorPicker> createState() => _ColorPicker();
}

class _ColorPicker extends State<ColorPicker>{

  List<Widget> ColorsPoints(){
    for(Color c in colors){

    }
    return colors.map((e) =>
        InkWell(
          onTap: () => widget.function(e),
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: e,
            ),

            width: MediaQuery.of(context).size.width * .1,
            height: MediaQuery.of(context).size.width * .1,
          ),
        )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return  GridView.count(
        crossAxisCount: 3,
        children: [ ...ColorsPoints()],
    );
  }
}


Future<void> colorAlert(BuildContext context){
  return showDialog(context: context,
      builder: (BuildContext _context){
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.width * .9,
      child: ColorPicker(function: (value){Navigator.pop(context, value); context.read<GameCubit>().updateColorTile(value);}),),
      actions: [
        ElevatedButton(onPressed: (){}, child: const Text('valider')),
      ],
    );
      });
}