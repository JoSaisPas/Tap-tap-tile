import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/widget/data.dart';
import 'package:game/widget/tile.dart';

enum StageTime {stage1, transition1, stage2, transition2, stage3}
class GameManager extends StatefulWidget{
  final Difficulty dif;
  final Color color;

  const GameManager({super.key, required this.dif, required this.color});

  @override
  State<GameManager> createState() => _GameManager();
}

const minSpeedTile = 1500;
const decreaseTime = 150;

const minTime = 250;
const decreaseSpeed = 500;

class _GameManager extends State<GameManager>{
  Queue<Tile> tiles = Queue();
  late Timer _timer;
  late double width = 0.0;
  late double height = 0.0;
  bool isFinish = false;
  int score = 1;
  int time = 1000;
  int speedTile = 2500;

  @override
  void initState(){
    super.initState();

    defineStage();
    stage = updateStage();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      width = MediaQuery.of(context).size.width / getDifficulty(widget.dif);
      height = MediaQuery.of(context).size.height * 0.2;

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
  void destroyTile(UniqueKey uniqueKey)  {
    setState(()  {
      tiles.remove(tiles.firstWhere((element) => element.key == uniqueKey));

      score++;

      if(stage != updateStage()){
        stage = updateStage();
        defineStage();
        createTimer();
      }
    });
  }


  ///Dif 1 :  speedTile = 2500  & time = 500  score 0 et 30
  ///       decrease progressif 30 40
  ///Dif 2 : speedTile = 2000  & time = 350   score 40 70
  ///       decrease progressif 70 - 80
  ///Dif 3: speedTile = 1500  & time = 250 80
  ///
  StageTime stage = StageTime.stage1;
  void defineStage(){
    switch (stage){
      case StageTime.stage1:
        speedTile = 2500;
        time = 500;
      case StageTime.transition1:
        speedTile = 2250;
        time = 475;
      case StageTime.stage2:
        speedTile = 2000;
        time = 350;
      case StageTime.transition2:
        speedTile = 1850;
        time = 300;
      case StageTime.stage3:
        speedTile = 1500;
        time = 250;
    }
  }



  StageTime updateStage(){
    if(score < 20){
      return  StageTime.stage1;
    }
    if(score >= 20 && score < 40 ){
      return StageTime.transition1;
    }

    if(score >= 40 && score < 70 ){
      return StageTime.stage2;
    }

    if(score >= 70 && score < 90 ){
      return StageTime.transition2;
    }

    return StageTime.stage3;

  }


  void finish(){
    isFinish = true;
    _timer.cancel();
    tiles.clear();
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
        ///when the user missclick a tile its finish the game
        GestureDetector(
        onTap: ()=> finish(),
    ),
    ...tiles,
    ],
    ));
  }

}