import 'package:estudiantes/models/pregunta.dart';
import 'db_helper.dart';

class DBPregunta extends DBHelper {
  
  DBPregunta() : super();

  Future<Pregunta> saveProduct(Pregunta pregunta) async {
    var dbClient = await db;
    pregunta.id = await dbClient.insert(DBHelper.TABLES[1], pregunta.toMap());
    return pregunta;
  }

  Future<List<Pregunta>> getAllProduct() async {
    var dbClient = await db;
    // List<Map> maps = await dbClient.query(DBHelper.TABLES[0], columns: ["id"]);
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM ${DBHelper.TABLES[1]}");
    List<Pregunta> pregunta = [];
    for (var item in maps) {
      pregunta.add(Pregunta.fromMap(item));
    }
    return pregunta;
  }
}