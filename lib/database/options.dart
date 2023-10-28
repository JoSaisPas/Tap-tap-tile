

import 'dart:ui';

import 'package:game/animated_background/models.dart';
import 'package:game/widget/data.dart';
import 'package:sqflite/sqflite.dart';

const  table = 'options';
const columnId = '_id';
const columnColorTile = 'colorTile';
const columnStyleButton= 'buttonStyle';
const columnModel = 'model';
const columnTheme = 'theme';
const columnColorButton = 'buttonColor';
const columnFontColorButton = 'buttonColorFont';

class Options{
  int? id;
  Color color_tile;
  StyleButton button_style;
  BackgroundStyle model;
  bool theme;
  Color button_color;
  bool button_color_font;

  Map<String,Object?> toMap(){

    final map = <String, Object?>{
      columnColorTile: color_tile.value,
      columnStyleButton: button_style.index,
      columnModel: model.index,
      columnTheme: theme ? 1 : 0,
      columnColorButton: button_color.value,
      columnFontColorButton: button_color_font ? 1 : 0,
    };

    if(id != null){map[columnId] = id;}
    return map;
  }

  Options({
    required this.color_tile,
    required this.button_style,
    required this.model,
    required this.theme,
    required this.button_color,
    required this.button_color_font,
    int? id}) : id = id;

  factory Options.fromMap(Map<String, dynamic> map){
    return Options(
        id : map[columnId],
        color_tile : Color(map[columnColorTile]),
        button_style : StyleButton.values[map[columnStyleButton]],
        model : BackgroundStyle.values[map[columnModel]],
        theme : map[columnTheme] == 1 ? true : false,
        button_color : Color(map[columnColorButton]),
        button_color_font : map[columnFontColorButton] == 1 ? true : false,
    );
  }
}

class OptionsProvider{

  late Database db;
  set setDb(Database db) => this.db = db;

  Future open(String path) async{
    db = await openDatabase(path, version : 1, onCreate: (Database db ,int version) async {
      await db.execute('''
      CREATE TABLE $table (
        $columnId integer primary key autoincrement,
        $columnColorTile integer not null,
        $columnStyleButton integer not null,
        $columnModel integer not null,
        $columnTheme boolean not null,
        $columnColorButton integer not null,
        $columnFontColorButton boolean not null)
      ''');
    });
  }

  Future createTable(String name, Database db) async{
    await db.execute('''
      CREATE TABLE $table (
        $columnId integer primary key autoincrement,
        $columnColorTile integer not null,
        $columnStyleButton integer not null,
        $columnModel integer not null,
        $columnTheme boolean not null,
        $columnColorButton integer not null,
        $columnFontColorButton boolean not null)
      ''');
  }


  Future<Options> insert(Options options) async{
    options.id = await db.insert(table, options.toMap());
    return options;
  }

  Future<int> delete(int id) async{
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future update(Options options, int id) async{
    return await db.update(table, options.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> close() async => db.close();

  Future<Options?> getOptionFromId(int id) async{
    List<Map<String, dynamic>> maps = await db.query(table, columns: [columnId, columnColorTile, columnStyleButton, columnModel, columnTheme, columnColorButton, columnFontColorButton], where: '$columnId = ?', whereArgs: [id]);
    if(maps.isNotEmpty){
      return Options.fromMap(maps.first);
    }
    return null;
  }
}