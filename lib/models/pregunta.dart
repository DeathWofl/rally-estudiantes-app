class Pregunta {
  
  final int id;
  final String preg;
	final int estacionID;

  Pregunta({this.id, this.preg, this.estacionID});

  factory Pregunta.fromJson(Map<String, dynamic> parsedJson) {
    return Pregunta(
      id: parsedJson['ID'],
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