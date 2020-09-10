import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:estudiantes/models/equipo.dart';
import 'package:estudiantes/models/pregunta.dart';
import 'package:estudiantes/models/regRespuestas.dart';
import 'package:estudiantes/models/respuestas.dart';


class DBHelper {
  
  //singleton class
  DBHelper._();
  static final DBHelper instance = DBHelper._();

  Database _database;
  static const List<String> TABLES = ['equipos', 'preguntas', 'regRespuestas', 'respuestas'];

  Future<Database> get database async {
    if (_database != null) return _database;
      _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory path = await getApplicationDocumentsDirectory();
    String rutadb = join(path.path, 'rally.db');
    return await openDatabase(rutadb, version: 1, onCreate: _oncreate, onOpen: _onOpen);
  }

  _onOpen(Database db) async {
    await db.execute("CREATE TABLE IF NOT EXISTS ${TABLES[0]} (id INTEGER PRIMARY KEY AUTOINCREMENT, matriculaE1 TEXT, matriculaE2 TEXT, matriculaE3 TEXT, codigoGrupo TEXT, contraGrupo TEXT, aPIID INTEGER);");
    await db.execute("CREATE TABLE IF NOT EXISTS ${TABLES[1]} (id INTEGER PRIMARY KEY AUTOINCREMENT, preg TEXT, apiID INTEGER, estacionID INTEGER);");
    await db.execute("CREATE TABLE IF NOT EXISTS ${TABLES[2]} (id INTEGER PRIMARY KEY AUTOINCREMENT, preguntaID INTEGER, calificacion INTEGER, equipoID INTEGER);");
    await db.execute("CREATE TABLE IF NOT EXISTS ${TABLES[3]} (id INTEGER PRIMARY KEY AUTOINCREMENT, resp TEXT, valor INTEGER, preguntaID INTEGER);");
  }

  _oncreate(Database db, int version) async {
    await db.execute("CREATE TABLE ${TABLES[0]} (id INTEGER PRIMARY KEY AUTOINCREMENT, matriculaE1 TEXT, matriculaE2 TEXT, matriculaE3 TEXT, codigoGrupo TEXT, contraGrupo TEXT, aPIID INTEGER);");
    await db.execute("CREATE TABLE ${TABLES[1]} (id INTEGER PRIMARY KEY AUTOINCREMENT, preg TEXT, apiID INTEGER, estacionID INTEGER);");
    await db.execute("CREATE TABLE ${TABLES[2]} (id INTEGER PRIMARY KEY AUTOINCREMENT, preguntaID INTEGER, calificacion INTEGER, equipoID INTEGER);");
    await db.execute("CREATE TABLE ${TABLES[3]} (id INTEGER PRIMARY KEY AUTOINCREMENT, resp TEXT, valor INTEGER, preguntaID INTEGER);");
  }

  void onmigrate() async {
    Database db = await database;
    await db.execute("DELETE FROM ${TABLES[0]};");
    await db.execute("DELETE FROM ${TABLES[1]};");
    await db.execute("DELETE FROM ${TABLES[2]};");
    await db.execute("DELETE FROM ${TABLES[3]};");
  }

  Future close() async {
    await _database.close();
  }

  Future<int> dataEquipo(String codigoGrupo) async {
    Database db = await database;
    // var result = await db.rawQuery("SELECT * FROM ${DBHelper.TABLES[0]} WHERE ");
    var result = await db.query(
      DBHelper.TABLES[0],
      columns: ['id', 'matriculaE1', 'matriculaE2', 'matriculaE3', 'codigoGrupo', 'contraGrupo','aPIID'],
        where: 'codigoGrupo = ?',
        whereArgs: [codigoGrupo]
    );
    Equipo val = Equipo.fromMap(result.first);
    return val.aPIID;
  }

  Future<Equipo> saveEquipo(Equipo equipo) async {
    Database db = await database;
    var result = await db.insert(DBHelper.TABLES[0], equipo.toMap(), nullColumnHack: "id");
    print("Equipo Guardado : $result");
    return equipo;
  }

  Future<List<Equipo>> getAllEquipo() async {
    Database db = await database;
    List<Map> maps = await db.rawQuery("SELECT * FROM ${DBHelper.TABLES[0]}");
    List<Equipo> equipo = [];
    for (var item in maps) {
      equipo.add(Equipo.fromMap(item));
    }
    return equipo;
  }

  Future<Equipo> login(String username) async {
    Database db = await database;
    List<Map> maps = await db.query(DBHelper.TABLES[0],
        columns: ['id', 'matriculaE1', 'matriculaE2', 'matriculaE3', 'codigoGrupo', 'contraGrupo'],
        where: 'matriculaE1 = ? OR matriculaE2 = ? OR matriculaE3 = ?',
        whereArgs: [username,username,username]);
    if (maps.length > 0) {
      return Equipo.fromMap(maps.first);
    }
    return null;
  }

  Future<Pregunta> savePregunta(Pregunta pregunta) async {
    Database db = await database;
    var result = await db.insert(DBHelper.TABLES[1], pregunta.toMap(),nullColumnHack: "id");
    print("Pregunta Guardado : $result");
    return pregunta;
  }

  Future<List<Pregunta>> getAllPregunta() async {
    Database db = await database;
    List<Map> maps = await db.query(DBHelper.TABLES[1]);
    List<Pregunta> pregunta = [];
    for (var item in maps) {
      pregunta.add(Pregunta.fromMap(item));
    }
    return pregunta;
  }

  Future<RegRespuestas> saveRegRespuesta(RegRespuestas regrespuestas) async {
    Database db = await database;
    var result = await db.insert(DBHelper.TABLES[2], regrespuestas.toMap(),nullColumnHack: "id");
    print("Registro de Respuesta Guardado : $result");
    return regrespuestas;
  }

  Future<List<RegRespuestas>> getAllRegRespuesta() async {
    Database db = await database;
    List<Map> maps = await db.rawQuery("SELECT * FROM ${DBHelper.TABLES[2]}");
    List<RegRespuestas> regrespuesta = [];
    for (var item in maps) {
      regrespuesta.add(RegRespuestas.fromMap(item));
    }
    return regrespuesta;
  }

  Future<Respuestas> saveRespuesta(Respuestas respuestas) async {
    Database db = await database;
    var result = await db.insert(DBHelper.TABLES[3], respuestas.toMap(), nullColumnHack: "id");
    print("Respuesta Guardado : $result");
    return respuestas;
  }

  Future<List<Respuestas>> getAllRespuestas() async {
    Database db = await database;
    List<Map> maps = await db.rawQuery("SELECT * FROM ${DBHelper.TABLES[3]}");
    List<Respuestas> respuesta = [];
    for (var item in maps) {
      respuesta.add(Respuestas.fromMap(item));
    }
    return respuesta;
  }

  Future<List<Pregunta>> getPregunta(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(DBHelper.TABLES[1],
        columns: ['id', 'preg', 'apiID','estacionID'],
        where: 'ID = ?',
        whereArgs: [id]);

    List<Pregunta> preguntas = [];
    for (var item in maps) {
      preguntas.add(Pregunta.fromMap(item));
    }
    return preguntas;
  }
  Future<List<Respuestas>> getRespuesta(int preguntaid) async {
    Database db = await database;
    List<Map> maps = await db.query(DBHelper.TABLES[3],
        columns: ['id', 'resp', 'valor', 'preguntaID'],
        where: 'preguntaID = ?',
        whereArgs: [preguntaid]);

    List<Respuestas> resp = [];
    for (var item in maps) {
      resp.add(Respuestas.fromMap(item));
    }
    return resp;
  }

}