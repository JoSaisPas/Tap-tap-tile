import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/widget/carousel.dart';

import '../database/scoreProvider.dart';
import '../gameController/game_state.dart';
import '../widget/data.dart';


Difficulty getDifFromStr(String str){
  switch(str){
    case '3X3':
      return Difficulty.easy;
    case '4X4':
      return Difficulty.middle;
    case '5X5':
      return Difficulty.hight;
  }
  return Difficulty.easy;
}
class LeaderBoard extends StatefulWidget{
  final ScoreProvider scoreProvider;
  final GameState state;
  const LeaderBoard({super.key, required this.scoreProvider, required this.state});
  @override
  State<LeaderBoard> createState() => _LeaderBoard();
}
class _LeaderBoard extends State<LeaderBoard>{


  ValueNotifier value  = ValueNotifier<dynamic>(1);
  void _onValueChange(dynamic v){
    value.value = v;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=> context.read<GameCubit>().home(),
          child: const Icon(Icons.arrow_back),),
        title: const Text('Back'),
      ),
      body:  Carousel(
        onSelectedItemChange: _onValueChange,
        list: const ['3X3', '4X4',  '5X5'],
        child: FutureBuilder(
            future: widget.scoreProvider.getScoreFromDif(getDifficulty(getDifFromStr((value.value).toString()))),
            builder: (context, snap){
              if(snap.connectionState == ConnectionState.done){
                return Positioned(
                    top: 20,
                    child:LeaderboardStyle(scores: snap.data));
              }
              // else{
              //   return const Center(child: Text('Pas de données pour cette difficutlés'),);
              // }

              return const Center(child:  CircularProgressIndicator(),);
            }
        ),
      ),
    );
  }
}

class LeaderboardStyle extends StatelessWidget{
  final List<Score>? scores;

  const LeaderboardStyle({super.key, required this.scores});

  ///Create a row with three Text
  Row _makeRow(String index, String name, String score){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child:Center(child: Text(index, style:const TextStyle(color: Colors.black, fontSize: 30)),),),
        Expanded(child: Center(child:Text(name,style:const TextStyle(color: Colors.black, fontSize: 30),),),),
        Expanded(child: Center(child:Text(score,style:const TextStyle(color: Colors.black, fontSize: 30)),),),
        const SizedBox(height: 50,),
      ],
    );
  }

  List<Widget> _getList(){
    List<Widget> list = [];
    scores?.reversed;
    for(int i= 0; i < (scores?.length ?? 0); i++){
      list.add(
          _makeRow(
              '${i+1}',
              '${scores?[i].name}',
              '${scores?[i].score}')
      );
    }

    while(list.length < 5){
      list.add(_makeRow('${list.length + 1}', '_', '_'));
    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ..._getList(),
        ],
      ),
    );
  }

}


