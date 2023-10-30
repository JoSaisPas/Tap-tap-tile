import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/widget/data.dart';
import 'package:game/widget/tile.dart';


class GameManager extends StatefulWidget{
  final Difficulty dif;
  final Color color;

  const GameManager({super.key, required this.dif, required this.color});

  @override
  State<GameManager> createState() => _GameManager();
}

const minSpeedTile = 800;
const decreaseTime = 60;

const minTime = 200;
const decreaseSpeed = 100;
const initalTime = 500;
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
          tiles.add( Tile(color: widget.color, width: width, height: height, pos: randomPos(), speed: speedTile, onEnd: finish, onDestroy: destroyTile, index: tiles.length, key: UniqueKey(),) );
        });
      });
    });
  }

  ///Create a new timer with a time in order to pop tiler often
  void createTimer(){
    if(_timer.isActive) {
      _timer.cancel();
    };
    _timer = Timer.periodic(Duration(milliseconds: time), (timer) {
      setState(() {
        tiles.add( Tile(color: widget.color, width: width, height: height, pos: randomPos(), speed: speedTile, onEnd: finish, onDestroy: destroyTile, index: tiles.length, key: UniqueKey(),) );
      });
    });
  }

  ///Randomize the tile position
  double randomPos(){
    int random = Random().nextInt(getDifficulty(widget.dif));
    return -1.0 + (random * (2/ (getDifficulty(widget.dif) - 1)));
  }

  ///Delete a tile
  ///Increase score
  void destroyTile(UniqueKey uniqueKey){
    setState(() {
      tiles.remove(tiles.firstWhere((element) => element.key == uniqueKey));
      score++;
      updateTime();
      updateSpeed();
    });
  }

  ///Change time (timer time) according to the current score
  void updateTime(){
    if(score % 10 == 0 && time > minTime){
      time -= decreaseTime;
      createTimer();
    }
  }

  ///Change the tile speed according to the current score
  void updateSpeed(){
    if(score % 10 == 0 && speedTile > minSpeedTile){
      speedTile -= decreaseSpeed;
    }
  }

  void finish(){
    isFinish = true;
    _timer.cancel();
    context.read<GameCubit>().finish(score);
  }

  @override
  void dispose(){
    _timer.cancel();
    tiles.clear();
    super.dispose();
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