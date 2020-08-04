import 'package:estudiantes/models/regRespuestas.dart';
import 'package:estudiantes/utils/db_helper.dart';

class DBRegRespuestas extends DBHelper {

  DBRegRespuestas() : super();

  Future<RegRespuestas> saveProduct(RegRespuestas regrespuestas) async {
    var dbClient = await db;
    regrespuestas.id = await dbClient.insert(DBHelper.TABLES[2], regrespuestas.toMap());
    return regrespuestas;
  }

  Future<List<RegRespuestas>> getAllProduct() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM ${DBHelper.TABLES[2]}");
    List<RegRespuestas> regrespuesta = [];
    for (var item in maps) {
      regrespuesta.add(RegRespuestas.fromMap(item));
    }
    return regrespuesta;
  }
  
}