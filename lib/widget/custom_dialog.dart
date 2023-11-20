import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/database/scoreProvider.dart';
import 'package:game/gameController/game_cubit.dart';
import 'package:game/gameController/game_state.dart';
import 'package:game/widget/data.dart';



class FinishDialog extends StatefulWidget{
  final GameState state;
  final ScoreProvider scoreProvider;

  const FinishDialog({super.key, required this.state, required this.scoreProvider});
  @override
  State<FinishDialog> createState() => _FinishDialog();
}
class _FinishDialog extends State<FinishDialog>{
  late Future<Score?> future;
  @override
  void initState(){
    super.initState();
    future = widget.scoreProvider.canUpdateLeaderboard(getDifficulty(widget.state.difficulty), widget.state.score);
  }
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<Score?>(
      future: future,
      builder: (context, snap){
        if(snap.connectionState == ConnectionState.done){
          return Dialog(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ContentPopUp(state: widget.state, newRecord: snap.data, scoreProvider: widget.scoreProvider,)));
        }
        return const CircularProgressIndicator();
      },

    );
  }


}


class ContentPopUp extends StatefulWidget{
  final GameState state;
  final Score? newRecord;
  final ScoreProvider scoreProvider;
  const ContentPopUp({super.key, required this.state, required this.newRecord, required this.scoreProvider});


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
        widget.scoreProvider.updateLeaderBoard(getDifficulty(widget.state.difficulty), s);
        function();
      }
    }else{
      function();
    }
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(10),
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