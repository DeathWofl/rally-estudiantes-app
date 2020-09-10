class Pregunta {
  
  int id;
  String preg;
	int estacionID;
  int apiID;

  Pregunta({this.id, this.preg, this.apiID, this.estacionID});

  factory Pregunta.fromJson(Map<String, dynamic> parsedJson) {
    return Pregunta(
      preg: parsedJson['Preg'],
      apiID: parsedJson['ID'],
      estacionID: parsedJson['EstacionID'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'id': id,
      'preg': preg,
      'apiID':apiID,
      'estacionID': estacionID,
    };
    return map;
  }

  Pregunta.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    preg = map['preg'];
    apiID = map['apiID'];
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