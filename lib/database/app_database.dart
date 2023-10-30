


import 'package:game/database/options.dart';
import 'package:game/database/scoreProvider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
   Database? db;
  late  ScoreProvider scoreProvider;
   late OptionsProvider optionsProvider;


  Future init() async{

    db = await openDatabase(join( await getDatabasesPath(), 'tap_tap_tile_database.db'), version : 1, onCreate: (Database db ,int version) async {
      ScoreProvider.createTable( db);
      OptionsProvider.createTable( db);
    }).then((value){
      scoreProvider = ScoreProvider(db: value);
      optionsProvider = OptionsProvider(db: value);
      return value;
    });

  }
}