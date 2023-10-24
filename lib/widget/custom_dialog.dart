

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/database/scoreProvider.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/gameController/game_state.dart';
import 'package:game/main.dart';
import 'package:game/widget/data.dart';


Dialog myDialog(BuildContext context, GameState state){
  return Dialog(
    child: Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Fin de la partie'),
          const Text('Votre score est de'),
          Text('${state.score}'),
          ///retour ecran choix difficulty
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              TextButton(onPressed: (){context.read<GameCubit>().chooseDifficulty();}, child: const Text('Back')),
              ///rejouer
              TextButton(onPressed: (){context.read<GameCubit>().game(state.difficulty);}, child: const Text('Play again')),
              ///leaderboard
              TextButton(onPressed: (){context.read<GameCubit>().leaderBoard();}, child: const Text('LeaderBoard')),
            ],
          )
        ],
      ),
    )
  );
}


/**
 * Pop up nouveau record
 * check la DB
 * affiche la place gagné
 * textfiel pour saisire le nom*/
Widget _newBestScore(BuildContext context, GameState state, ScoreProvider scoreProvider){
  TextEditingController controller = TextEditingController();
  controller.addListener(() { });
  bool correctName(){
    if(controller.value.text.isNotEmpty){
      return true;
    }
    return false;
  }
  return  Column(

    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text('Nouveau record !!!'),
      Text('${state.score}'),
        TextField(
         controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text('Pseudo'),
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          TextButton(onPressed: (){
              if(correctName()){
                context.read<GameCubit>().chooseDifficulty();
              }
            }, child: const Text('Back')),
          ///rejouer
          TextButton(onPressed: (){
          //if(correctName()) {
            scoreProvider.insert(Score(difficulty :getDifficulty(state.difficulty), score :state.score, name: controller.value.text, ));

            context.read<GameCubit>().game(state.difficulty);
          //}
            }, child: const Text('Play again')),
          ///leaderboard
          TextButton(onPressed: (){
            if(correctName()) {
              context.read<GameCubit>().leaderBoard();
            }
            }, child: const Text('LeaderBoard')),
        ],
      )
    ],
  );
}

Widget _endGame(context,state){
  return  Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text('Fin de la partie'),
      const Text('Votre score est de'),
      Text('${state.score}'),
      ///retour ecran choix difficulty
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          TextButton(onPressed: (){context.read<GameCubit>().chooseDifficulty();}, child: const Text('Back')),
          ///rejouer
          TextButton(onPressed: (){context.read<GameCubit>().game(state.difficulty);}, child: const Text('Play again')),
          ///leaderboard
          TextButton(onPressed: (){context.read<GameCubit>().leaderBoard();}, child: const Text('LeaderBoard')),
        ],
      )
    ],
  );
}
Future<void> test() async{
  await Future.delayed(Duration(seconds: 1));
}


///check if new record
Future<bool>? isNewRecord(GameState state, ScoreProvider scoreProvider) async {
  List<Score>? list = await scoreProvider.getScoreFromDif(getDifficulty(state.difficulty));
  print('hallo');
  if(list == null){
    return true;
  }

  if(list.length < 5){
    return true;
  }

  for(Score score in list){
    if(score.score! < state.score){
      return true;
    }
  }

  return false;
}

class testFuture extends StatefulWidget{
  final GameState state;
  final ScoreProvider scoreProvider;

  const testFuture({super.key, required this.state, required this.scoreProvider});
  State<testFuture> createState() => _testFuture();
}
class _testFuture extends State<testFuture>{
  late Future<Score?> future;
  @override
  void initState(){
    super.initState();
    future = scoreProvider.canUpdateLeaderboard(getDifficulty(widget.state.difficulty), widget.state.score);
  }
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<Score?>(
      future: future,
      builder: (context, snap){
        if(snap.connectionState == ConnectionState.done){
          //if(snap.hasData){
          print('aaaaaaaaaa');
          return Dialog(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ContentPopUp(state: widget.state, newRecord: snap.data)));
        }
        return const CircularProgressIndicator();
      },

    );
  }


}
FutureBuilder myDialog2(BuildContext context, GameState state, ScoreProvider scoreProvider){
  return  FutureBuilder<Score?>(
          future: scoreProvider.canUpdateLeaderboard(getDifficulty(state.difficulty), state.score),
          builder: (context, snap){
            if(snap.connectionState == ConnectionState.done){
            //if(snap.hasData){

              return Dialog(
                  child: Container(
                  padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.4,
            child: ContentPopUp(state: state, newRecord: snap.data)));
            }
            return const CircularProgressIndicator();
          },

  );
}

class ContentPopUp extends StatefulWidget{
  final GameState state;
  final Score? newRecord;
  const ContentPopUp({super.key, required this.state, required this.newRecord});


  @override
  State<ContentPopUp> createState() => _ContentPopUp();
}

class _ContentPopUp extends State<ContentPopUp>{
  late TextEditingController controller;
  bool _validate = true;
  @override
  void initState(){
    super.initState();
    controller = TextEditingController();
    controller.text = widget.newRecord?.name ?? '';
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  void _valideTxt(){
    setState(() {
      if(controller.text.length > 10 || controller.text.isEmpty){
        _validate = false;

      }else{
        _validate = true;
      }
    });
  }

  void _valideTap(Function function){

    _valideTxt();
    if(widget.newRecord != null){
      if(_validate){
        Score s = Score(name: controller.text, score: widget.state.score, difficulty: getDifficulty(widget.state.difficulty));
        scoreProvider.updateLeaderBoard(getDifficulty(widget.state.difficulty), s);
        function();
      }
    }else{
      function();
    }
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Fin de la partie'),
          const Text('Votre score est de'),
          Text('${widget.state.score}'),

          widget.newRecord != null
              ? const Text('Nouveau record !!!')
              : const SizedBox(),

          widget.newRecord != null
              ? TextField(
                controller: controller,
                decoration:   InputDecoration(

                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  label: const Text('Pseudo (10 characters max)'),
                  errorText: _validate ? null :'Pseudo can\'t be empty or bigger than 10 characters',
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: _validate ? Colors.black :Colors.red)),
                ),
            )
              : const SizedBox.shrink(),

          ///retour ecran choix difficulty
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              TextButton(onPressed: (){
                _valideTap(() => context.read<GameCubit>().chooseDifficulty());
                }, child: const Text('Back')),
              ///rejouer
              TextButton(onPressed: (){
               _valideTap(() => context.read<GameCubit>().game(widget.state.difficulty));


                }, child: const Text('Play again')),
              ///leaderboard
              TextButton(onPressed: (){
              _valideTap(() => context.read<GameCubit>().leaderBoard());

                }, child: const Text('LeaderBoard')),
            ],
          )
        ],
      ),
    );
  }
}