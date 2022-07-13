import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final String _tableName = "Notes";
  static final String columnId = "Id";
  static final String columnTitle = "Title";
  static final String columnImage = "Image";
  static final String columnDescription = "Description";
  static final _dbName = "my.db";
  static final _dbVersion = 1;
  DBHelper._dbHelper();
  static final DBHelper instance = DBHelper._dbHelper();
  static Database? _dataBase;

  Future<Database> get database async {
    if (_dataBase != null) {
      print("================11111");
      return _dataBase!;
    }

    _dataBase = await _initDatabase();
    print("1111111${_dataBase!.path}");
    return _dataBase!;
  }

  _initDatabase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();

      String _path = directory.path + "/" + _dbName;

      print("_path");
      return await openDatabase(_path,
          version: _dbVersion, onCreate: _onCreate);
    } catch (e) {
      print("Intialize db Error==========================$e");
    }
  }

  Future _onCreate(Database db, int version) async {
    print("object");
    try {
      print("object");
      await db.execute(""" CREATE TABLE $_tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnTitle TEXT NOT NULL,
      $columnDescription TEXT ,
      $columnImage BLOB 
    )""");
    } catch (e) {
      print("Create  db tableError==========================$e");
    }
  }

  Future<int> insert(Map<String, dynamic> data) async {
    try {
      Database db = await instance.database;
      print("========${db.path}");
      await db.execute(""" CREATE TABLE IF NOT EXISTS  $_tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnTitle TEXT NOT NULL,
 $columnDescription TEXT ,
      $columnImage BLOB 
    )""");
      return await db.insert(_tableName, data);
    } catch (e) {
      print("inser in db Error==========================$e");
      return 0;
    }
  }

  drpotable() async {
    Database db = await instance.database;

    db.execute(""" DROP TABLE $_tableName""");
  }

  Future<List<NotesModel>> queryAll() async {
    try {
      Database db = await instance.database;
      final _data = await db.query(_tableName);
      return List.generate(
          _data.length, (index) => NotesModel.fromJson(_data[index]));
    } catch (e) {
      print("Querry Error===============$e");
      return [];
    }
  }

  Future update(Map<String, dynamic> data) async {
    int id = data[columnId];
    Database db = await instance.database;

    await db.update(_tableName, data, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;

    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}

class NotesModel {
  final int id;
  final String title;
  final String? description;
  String? image;

  NotesModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.image});

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
        id: json["Id"],
        title: json["Title"],
        description: json["Description"],
        image: json["Image"]);
  }

  Map<String, dynamic> toJson() =>
      {"Id": id, "Title": title, "Description": description, "Image": image};
}
