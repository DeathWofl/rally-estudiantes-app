class Pregunta {
  
  int id;
  String preg;
	int estacionID;

  Pregunta({this.id, this.preg, this.estacionID});

  factory Pregunta.fromJson(Map<String, dynamic> parsedJson) {
    return Pregunta(
      id: parsedJson['ID'],
      preg: parsedJson['Preg'],
      estacionID: parsedJson['EstacionID'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'id': id,
      'preg': preg,
      'estacionID': estacionID,
    };
  }

  Pregunta.fromMap(Map<String, dynamic> map) {
    id = map['id'];
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