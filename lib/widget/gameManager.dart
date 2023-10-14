import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/widget/data.dart';
import 'package:game/widget/tile.dart';

import 'custom_dialog.dart';


/**
 * gestion du score et du temps
 * pour chaque tile touché, le score augmente
 * */


/**
 * un cubit qui gere
 * la liste de tile : pour conserver l'etat après un changement de vitesse
 * le score
 * le timing (influencé par le score )
 * la difficulté
 * le thème des tiles
 * */
class GameManager extends StatefulWidget{
  final Difficulty dif;
  final Color color;

  const GameManager({super.key, required this.dif, required this.color});

  @override
  State<GameManager> createState() => _GameManager();
}

const minSpeedTile = 800;
const decreaseTime = 50;

const minTime = 200;
const decreaseSpedd = 100;
const initalTime = 600;
const initalSpeedTile = 2000;

class _GameManager extends State<GameManager>{
  Queue<Tile> tiles = Queue();
  late Timer _timer;
  late double width = 0.0;
  late double height = 0.0;
  bool isFinish = false;
  int score = 0;
  int time = 600;
  int speedTile = 2000;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      width = MediaQuery.of(context).size.width / getDifficulty(widget.dif);
      height = MediaQuery.of(context).size.height * 0.18;

      _timer = Timer.periodic( Duration(milliseconds: time), (timer) {
        setState(() {
          tiles.add( Tile(color: widget.color, width: width, height: height, pos: randomPos(), speed: speedTile, onEnd: finish, onDestroy: destroy, index: tiles.length, key: UniqueKey(),) );
        });
      });
    });
  }


  void createTimer(){
    if(_timer.isActive) {
      print('active');
      _timer.cancel();
    };
    _timer = Timer.periodic(Duration(milliseconds: time), (timer) {
      setState(() {
        tiles.add( Tile(color: widget.color, width: width, height: height, pos: randomPos(), speed: speedTile, onEnd: finish, onDestroy: destroy, index: tiles.length, key: UniqueKey(),) );
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
      score++;
      print('score : $score');
      updateTime();
      updateSpeed();
    });
  }

  void updateTime(){
    if(score % 10 == 0 && time > minTime){
      time -= decreaseTime;
      print('time : $time');
      createTimer();
    }
  }

  void updateSpeed(){
    if(score % 10 == 0 && speedTile > minSpeedTile){
      speedTile -= decreaseSpedd;
      print('speed : $speedTile');
    }
  }

  void finish(){
    isFinish = true;
    _timer.cancel();
    context.read<GameCubit>().finish(score);
  }

  @override
  void dispose(){
    super.dispose();
    _timer.cancel();
    tiles.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ...tiles
        ],
      ),
    );
  }

}