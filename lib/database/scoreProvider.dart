// https://pub.dev/packages/sqflite

import 'package:sqflite/sqflite.dart';

const  table = 'score';
const columnId = '_id';
const columnName = '_name';
const columnDifficulty = '_difficulty';
const columnScore = '_score';

class Score{
  int? id;
  String name;
  int score;
  int difficulty;

  Map<String,Object?> toMap(){
    final map = <String, Object?>{
      columnName : name,
      columnDifficulty : difficulty,
      columnScore : score,
    };

    if(id != null){map[columnId] = id;}
    return map;
  }

  Score({required this.difficulty, required this.name, required this.score, int? id}) : id = id;

  factory Score.fromMap(Map<String, dynamic> map){
    return Score(
    id : map[columnId],
    score : map[columnScore],
    difficulty : map[columnDifficulty],
    name : map[columnName]
    );
  }
}


class ScoreProvider{
  ScoreProvider({required this.db});
  late Database db;

  ///only for Test
  ScoreProvider.forTest();

  Future open(String path) async{
    db = await openDatabase(path, version : 1, onCreate: (Database db ,int version) async {
      await db.execute('''
      CREATE TABLE $table (
        $columnId integer primary key autoincrement,
        $columnDifficulty integer not null,
        $columnName text not null,
        $columnScore integer not null)
      ''');
    });
  }
  //-------------------------------

  static Future createTable( Database db) async{
    await db.execute('''
      CREATE TABLE $table (
        $columnId integer primary key autoincrement,
        $columnDifficulty integer not null,
        $columnName text not null,
        $columnScore integer not null)
      ''');
  }


  Future<Score> insert(Score score) async{
    score.id = await db.insert(table, score.toMap());
    return score;
  }

  Future<int> delete(int id) async{
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future update(Score score) async{
    return await db.update(table, score.toMap(), where: '$columnId = ?', whereArgs: [score.id]);
  }

  Future<void> close() async => db.close();

  Future<Score?> getScoreFromId(int id) async{
    List<Map<String, dynamic>> maps = await db.query(table, columns: [columnId, columnDifficulty, columnName, columnScore], where: '$columnId = ?', whereArgs: [id]);
    if(maps.isNotEmpty){
      return Score.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Score>?> getScoreFromDif(int dif) async{
    List<Map<String, dynamic>> maps  = await db.query(table, columns: [columnId, columnDifficulty, columnName, columnScore], where: '$columnDifficulty = ?', whereArgs: [dif], orderBy:  '$columnScore DESC');
    if(maps.isEmpty){
      return null;
    }
    return maps.map((e) => Score.fromMap(e)).toList();
  }

  bool lessThanFiveRowForDifficult(List<Score>? scores) {
    return ( scores == null  || scores.length < 5);
  }


  Future<Score?> canUpdateScore(List<Score>? scores, int score) async{
    Score? updatable;
    bool find = false;
    int index = 0;
    while(index < scores!.length && !find){
      if(scores[index].score <= score) {
        updatable = scores[index];
        find = true;
      }
      index++;
    }

    return updatable;
  }

  Future<Score?> canUpdateLeaderboard(int dif, int score) async{
    List<Score>? scores = await getScoreFromDif(dif);
    if(lessThanFiveRowForDifficult(scores)){
      return Score(difficulty: dif, name: 'Pseudo', score: score);
    }
    return canUpdateScore(scores, score);
  }

  Future updateLeaderBoard(int dif, Score score) async {

    List<Score>? scores = await getScoreFromDif(dif);
    if(lessThanFiveRowForDifficult(scores)){
      insert(score);
    }else{
      Score? update = await canUpdateScore(scores, score.score!);
      if(update != null){
        update.score = score.score;
        update.name = score.name;
        this.update(update);
      }
    }
  }



}