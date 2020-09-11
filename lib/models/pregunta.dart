import 'package:hive/hive.dart';

part 'pregunta.g.dart';

@HiveType(typeId: 1)
class Pregunta {
  
  // int id;
  @HiveField(0)
  String preg;
  @HiveField(1)
	int estacionID;
  @HiveField(2)
  int apiID;

  Pregunta({/*this.id,*/ this.preg, this.estacionID, this.apiID});

  factory Pregunta.fromJson(Map<String, dynamic> parsedJson) {
    return Pregunta(
      apiID: parsedJson['ID'],
      preg: parsedJson['Preg'],
      estacionID: parsedJson['EstacionID'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'apiID': apiID,
      'preg': preg,
      'estacionID': estacionID,
    };
  }

  Pregunta.fromMap(Map<String, dynamic> map) {
    apiID = map['apiID'];
    preg = map['preg'];
    estacionID = map['estacionID'];
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