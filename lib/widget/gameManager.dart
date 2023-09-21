


import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game/widget/data.dart';
import 'package:game/widget/tile.dart';

class GameManager extends StatefulWidget{
  final Difficulty dif;

  const GameManager({super.key, required this.dif});

  @override
  State<GameManager> createState() => _GameManager();
}


class _GameManager extends State<GameManager>{
  Queue<Tile> tiles = Queue();
  late Timer _timer;
  late double width = 0;
  bool isFinish = false;


  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      width = MediaQuery.of(context).size.width / getDifficulty(widget.dif);
    });

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        tiles.add( Tile(color: Colors.red, width: width, height: 200, pos: randomPos(), speed: 0.0, onEnd: destroy, index: tiles.length, key: UniqueKey(),) );
      });
    });
  }

  ///Défini la position d'un tile de façon aléatoir
  double randomPos(){
    /// [0 ;getDifficulty(dif)]
    int random = Random().nextInt(getDifficulty(widget.dif));
    return -1.0 + (random * (2/ (getDifficulty(widget.dif) - 1)));
  }

  void destroy(){
    setState(() {
      tiles.remove(tiles.first);
    });
  }

  void finish(){
    setState(() {
      isFinish = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...tiles
      ],
    );
  }

}