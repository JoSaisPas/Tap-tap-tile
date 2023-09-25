import 'dart:async';

import 'package:flutter/material.dart';

const offScreenTop = -2.0;
/*
* largeur : dépend du nombre de colonne donc de la difficulté
* hauter : fix ?
* couleur : dépend du choix de l'utilisateur
* possition : random
* vitesse : temps de la partie*/
class Tile extends StatefulWidget{
  final Color color;
  final double width;
  final double height;
  final double pos;
  final int speed;
  final Function onEnd;
  final Function onDestroy;
  final int index;
  const Tile({super.key,
    required this.color,
    required this.width,
    required this.height,
    required this.pos,
    required this.speed,
    required this.onEnd,
    required this.index,
    required this.onDestroy,
  });

  @override
  State<Tile> createState() => _Tile();
}

class _Tile extends State<Tile>{

  late Timer _timer;
  bool isDroping = false;
  @override
  void initState(){
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if(timer.tick == 1){
        timer.cancel();
        setState(() {
          isDroping = !isDroping;
        });
      }
    });
  }
  double t = 1;
  @override
  Widget build(BuildContext context){
    return AnimatedAlign(
      alignment: isDroping ?  Alignment(widget.pos.toDouble(), 1) : Alignment(widget.pos.toDouble(), offScreenTop) ,
      duration:  Duration(milliseconds: widget.speed),
      onEnd:  (){
        widget.onEnd();
      },
      child: InkWell(
        onTap: (){
          widget.onDestroy();
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          color: widget.color,
          child: Center(child: Text('${widget.index}'),),
        ),
      )
    );
  }
}