import 'package:estudiantes/models/equipo.dart';
import 'package:estudiantes/utils/db_helper.dart';

class DBEquipo extends DBHelper {
  DBEquipo() : super();

  Future<Equipo> saveProduct(Equipo equipo) async {
    var dbClient = await db;
    equipo.iD = await dbClient.insert(DBHelper.TABLES[0], equipo.toMap());
    return equipo;
  }

  Future<List<Equipo>> getAllProduct() async {
    var dbClient = await db;
    // List<Map> maps = await dbClient.query(DBHelper.TABLES[0], columns: ["id"]);
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM ${DBHelper.TABLES[0]}");
    List<Equipo> equipo = [];
    for (var item in maps) {
      equipo.add(Equipo.fromMap(item));
    }
    return equipo;
  }
  
}