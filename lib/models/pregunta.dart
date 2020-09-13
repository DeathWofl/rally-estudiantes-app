import 'package:hive/hive.dart';

part 'pregunta.g.dart';

@HiveType(typeId: 1)
class Pregunta {
  
  @HiveField(0)
  String preg;
  @HiveField(1)
	int estacionID;
  @HiveField(2)
  int apiID;

  Pregunta({this.preg, this.estacionID, this.apiID});

  factory Pregunta.fromJson(Map<String, dynamic> parsedJson) {
    return Pregunta(
      apiID: parsedJson['ID'],
      preg: parsedJson['Preg'],
      estacionID: parsedJson['EstacionID'],
    );
  }
}

class PreguntaList {
  List<Pregunta> pregunta;
  PreguntaList({this.pregunta});

  factory PreguntaList.fromJson(List<dynamic> parsedJson) {
    List<Pregunta> preguntas = List<Pregunta>();
    preguntas = parsedJson.map((e) => Pregunta.fromJson(e)).toList();

    return PreguntaList(pregunta: preguntas);
  }
}