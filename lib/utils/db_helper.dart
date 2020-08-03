import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DBHelper {
  
  static Database _db;
  static const List<String> TABLES = ['equipos', 'preguntas', 'regRespuestas', 'respuestas'];

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    String path = await getDatabasesPath();
    var db = openDatabase(join(path, 'rally.db'), version: 1, onCreate: _oncreate);
    return db;
  }

  _oncreate(Database db, int version) async {
    await db.execute("CREATE TABLE ${TABLES[0]} (id INTEGER PRIMARY KEY, matriculaE1 TEXT, matriculaE2 TEXT, matriculaE3 TEXT, codigoGrupo TEXT, contraGrupo TEXT)");
    await db.execute("CREATE TABLE ${TABLES[1]} (id INTEGER PRIMARY KEY, preg TEXT, estacionID INTEGER)");
    await db.execute("CREATE TABLE ${TABLES[2]} (id INTEGER PRIMARY KEY, preguntaID INTEGER, calificacion INTEGER, equipoID INTEGER)");
    await db.execute("CREATE TABLE ${TABLES[3]} (id INTEGER PRIMARY KEY, resp TEXT, valor INTEGER, preguntaID INTEGER)");
  }

  Future close() async {
    var dbClient = await db;
    await dbClient.close();
  }


}