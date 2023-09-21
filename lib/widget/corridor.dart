import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:game/widget/data.dart';
import 'package:game/widget/tile.dart';


/*
* height : full screen
* width : dépend de la difficulté
* */
class Corridor extends StatefulWidget{

  final Difficulty dif;
  const Corridor({super.key, required this.dif});
  @override
  State<Corridor> createState() => _Corridor();
}


class _Corridor extends State<Corridor>{

  List<Widget> list = [];
  double width = 0;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     setState(() {
       width = MediaQuery.of(context).size.width / getDifficulty(widget.dif);
       for(int i =0; i < getDifficulty(widget.dif); i++){
         list.add(
           Align(
             alignment: Alignment(-1 + (i * (2/ (getDifficulty(widget.dif) - 1))), 0),
             child: Container(width: width, height: MediaQuery.of(context).size.height,color: Colors.primaries[i], child: Center(child: Text('$width'),),),
           )
         );
       }
     });
    });
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    list.clear();

      width = MediaQuery.of(context).size.width / getDifficulty(widget.dif);
      for(int i =0; i < getDifficulty(widget.dif); i++){
        list.add(
            Align(
              alignment: Alignment(-1 + (i * (2/ (getDifficulty(widget.dif) - 1))), 0),
              child: Container(width: width, height: MediaQuery.of(context).size.height,color: Colors.primaries[i], child: Center(child: Text('$width'),),),
            )
        );
      }
  }

  @override
  Widget build(BuildContext context){
    return Container(
     child: Stack(
       children: [...list],
     ),
    );
  }
}