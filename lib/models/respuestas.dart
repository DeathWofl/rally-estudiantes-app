import 'package:hive/hive.dart';

part 'respuestas.g.dart';

@HiveType(typeId: 2)
class Respuestas {
  
  // int iD;
  @HiveField(0)
  String resp;
  @HiveField(1)
	int valor;
  @HiveField(2)
	int preguntaID;

  Respuestas({this.resp, this.valor, this.preguntaID});

  factory Respuestas.fromJson(Map<String, dynamic> parsedJson) {
    return Respuestas(
      resp: parsedJson['Resp'],
      valor: parsedJson['Valor'],
      preguntaID: parsedJson['PreguntaID'],
    );
  }

}

class ListRespuestas {
  
  final List<Respuestas> respuesta;
  ListRespuestas({this.respuesta});

  factory ListRespuestas.fromJson(List<dynamic> parsedJson) {
    List<Respuestas> respuestas = List<Respuestas>();
    respuestas = parsedJson.map((e) => Respuestas.fromJson(e)).toList();

    return ListRespuestas(respuesta: respuestas);
  }
}