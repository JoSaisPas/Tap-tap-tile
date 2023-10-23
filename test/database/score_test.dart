
import 'package:flutter_test/flutter_test.dart';
import 'package:game/database/scoreProvider.dart';
import 'package:game/widget/data.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}


Future main() async {
  sqfliteTestInit();


  group('ScoreProvider Unit test (CRUD)', () {

    test('Open', () async {
      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);
      expect(scoreProvider.db.isOpen, true);
      scoreProvider.close();
    });

    test('Close', () async {
      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);
      await scoreProvider.close();
      expect(scoreProvider.db.isOpen, false);
    });

    test('Insert', ()  async{
      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);
      Score score = Score(difficulty: 1, name: 'test', score: 1);
      expect(await scoreProvider.insert(score), score);
      await scoreProvider.close();
    });

    test('getScore', ()  async{
      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);

      Score score = Score(difficulty: 1, name: 'test', score: 1);
      await scoreProvider.insert(score);

      Score? scoreFromDB = await scoreProvider.getScoreFromId(1);
      expect(scoreFromDB != null, true);
      expect(scoreFromDB, isA<Score>());

      expect(scoreFromDB?.id, 1);
      expect(scoreFromDB?.name, 'test');
      expect(scoreFromDB?.score, 1);
      expect(scoreFromDB?.difficulty, 1);

      await scoreProvider.close();
    });


    test('Update', ()  async{
      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);

      Score score = Score(difficulty: 1, name: 'test', score: 1);
      scoreProvider.insert(score);
      expect((await scoreProvider.getScoreFromId(1))?.score, 1);

      score.score = 55;
      scoreProvider.update(score);
      expect((await scoreProvider.getScoreFromId(1))?.score, 55);
      await scoreProvider.close();
    });

    test('Delete', ()  async{
      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);

      Score score = Score(difficulty: 1, name: 'test', score: 1);
      scoreProvider.insert(score);
      expect(await scoreProvider.getScoreFromId(1), isA<Score>());

      await scoreProvider.delete(score.id!);
      expect(await scoreProvider.getScoreFromId(1), null);

      await scoreProvider.close();
    });

  });

  group('updateLeaderboard', () {

    Score score_easy_1 = Score(difficulty: getDifficulty(Difficulty.easy), name: 'test', score: 100);
    Score score_easy_2 = Score(difficulty: getDifficulty(Difficulty.easy), name: 'test', score: 180);
    Score score_easy_3 = Score(difficulty: getDifficulty(Difficulty.easy), name: 'test', score: 14);
    Score score_easy_4 = Score(difficulty: getDifficulty(Difficulty.easy), name: 'test', score: 45);
    Score score_easy_5 = Score(difficulty: getDifficulty(Difficulty.easy), name: 'test', score: 60);
    List<Score> scores_easy = [ score_easy_1, score_easy_2, score_easy_3, score_easy_4, score_easy_5];

    Score score_middle_1 =Score(difficulty: getDifficulty(Difficulty.middle), name: 'middle', score: 100);


    test('getFromDif', ()async {
      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);

      for(Score s in scores_easy){
        scoreProvider.insert(s);
      }

      scoreProvider.insert(score_middle_1);


      expect((await scoreProvider.getScoreFromDif(getDifficulty(Difficulty.easy)))?.length, 5);
      expect((await scoreProvider.getScoreFromDif(getDifficulty(Difficulty.middle)))?.length, 1);


      await scoreProvider.close();
    });

    test('getFromDif should be ordered DESC', ()async {
      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);

      for(Score s in scores_easy){
        scoreProvider.insert(s);
      }

      List<Score>? score_from_db = await scoreProvider.getScoreFromDif(getDifficulty(Difficulty.easy));

      expect(score_from_db?[0].score, 180);
      expect(score_from_db?[1].score, 100);
      expect(score_from_db?[2].score,60);
      expect(score_from_db?[3].score, 45);
      expect(score_from_db?[4].score, 14);

      await scoreProvider.close();
    });




    test('Five scores can be saves for a specif difficulty ', () async {

      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);

      List<Score>? score_from_db = await scoreProvider.getScoreFromDif(getDifficulty(Difficulty.easy));

      ///Empty : should return true
      expect(scoreProvider.lessThanFiveRowForDifficult(score_from_db), true);

      score_from_db?.clear();
      scoreProvider.insert(score_easy_1);
      scoreProvider.insert(score_easy_2);
      scoreProvider.insert(score_easy_3);
      score_from_db = await scoreProvider.getScoreFromDif(getDifficulty(Difficulty.easy));
      ///only 3 scores saved : should return true
      expect(scoreProvider.lessThanFiveRowForDifficult(score_from_db), true);

      scoreProvider.insert(score_easy_4);
      scoreProvider.insert(score_easy_5);
      score_from_db?.clear();
      score_from_db = await scoreProvider.getScoreFromDif(getDifficulty(Difficulty.easy));
      ///5 scorese saved : should return false
      expect(scoreProvider.lessThanFiveRowForDifficult(score_from_db), false);

      await scoreProvider.close();
    });


    test('should return the index fof updatable score if new score is bigger', ()  async{
      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);

      for(Score s in scores_easy){
        scoreProvider.insert(s);
      }

      List<Score>? score_from_db = await scoreProvider.getScoreFromDif(getDifficulty(Difficulty.easy));

      Score new_first = Score(difficulty: getDifficulty(Difficulty.easy), name: 'yeah', score: 200);
      expect((await scoreProvider.canUpdateScore(score_from_db, new_first.score))?.score, scores_easy[1].score);

      Score new_third = Score(difficulty: getDifficulty(Difficulty.easy), name: 'yeah', score: 80);
      expect((await scoreProvider.canUpdateScore(score_from_db, new_third.score))?.score, scores_easy?[4].score);

      Score failure = Score(difficulty: getDifficulty(Difficulty.easy), name: 'yeah', score: 0);
      expect((await scoreProvider.canUpdateScore(score_from_db, failure.score)), null);


      await scoreProvider.close();
    });



    test('canUpdateLeaderBoard', ()  async{
      ScoreProvider scoreProvider = ScoreProvider();
      await scoreProvider.open(inMemoryDatabasePath);

      for(Score s in scores_easy){
        scoreProvider.insert(s);
      }

      scoreProvider.delete(4);

      ///4 scores saved, should return Score with empty name and current score & dif
      Score lambda = Score(difficulty: getDifficulty(Difficulty.easy), name: 'test', score: 0);
      expect((await scoreProvider.canUpdateLeaderboard(getDifficulty(Difficulty.easy),lambda.score))?.score, 0);
      expect((await scoreProvider.canUpdateLeaderboard(getDifficulty(Difficulty.easy),lambda.score))?.name, '');
      scoreProvider.insert(lambda);
      ///5 scores saved, should return the first entry that match condition db.score <= score_param
      ///here is 180
      Score new_best = Score(difficulty: getDifficulty(Difficulty.easy), name: 'pouet', score: 421);
      expect((await scoreProvider.canUpdateLeaderboard(getDifficulty(Difficulty.easy),new_best.score))?.name, 'test');
      expect((await scoreProvider.canUpdateLeaderboard(getDifficulty(Difficulty.easy),new_best.score))?.score, 180);

      scoreProvider.close();
    });

  });


}


