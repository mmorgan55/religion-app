import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'models/definition.dart';

class DatabaseHelper {
  static DatabaseHelper databaseHelper;
  static Database database;

  String definitionTable = "defintion_table";
  String colId = "id";
  String colWord = "word";
  String colDefinition = "definition";

  DatabaseHelper.createInstance();

  factory DatabaseHelper() {
    if (databaseHelper == null) {
      databaseHelper = DatabaseHelper.createInstance();
    }

    return databaseHelper;
  }

  Future<Database> get getDatabase async {
    if (database == null) {
      database = await initializeDatabase();
    }

    return database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "defintion.db";
    var definitionsDatabase =
        openDatabase(path, version: 1, onCreate: createDatabase);
    return definitionsDatabase;
  }

  void createDatabase(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $definitionTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colWord TEXT, $colDefinition TEXT)');
  }

  //CRUD Operations

  //FETCH
  Future<List<Map<String, dynamic>>> getDefintionMapList() async {
    Database db = await this.getDatabase;

    var result = await db.query(definitionTable, orderBy: 'colWord DESC');
    return result;
  }

  //INSERT
  Future<int> insertDefinition(Definition definition) async {
    Database db = await this.getDatabase;
    var result = await db.insert(definitionTable, definition.toMap());

    return result;
  }

  //UPDATE
  Future<int> updateDefinition(Definition definition) async {
    var db = await this.getDatabase;
    var result = await db.update(definitionTable, definition.toMap(),
        where: 'colId = ?', whereArgs: [definition.id]);

    return result;
  }

  //DELETE
  Future<int> deleteDefinition(int id) async {
    var db = await this.getDatabase;
    int result =
        await db.rawDelete('DELETE FROM $definitionTable WHERE $colId = $id');

    return result;
  }

  Future<int> getCount() async {
    Database db = await this.getDatabase;
    List<Map<String, dynamic>> num =
        await db.rawQuery('SELECT COUNT (*) FROM $definitionTable');
    int result = Sqflite.firstIntValue(num);

    return result;
  }
}
