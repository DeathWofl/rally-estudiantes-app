class Respuestas {
  
  final int iD;
  final String resp;
	final int valor;
	final int preguntaID;

  Respuestas({this.iD, this.resp, this.valor, this.preguntaID});

  factory Respuestas.fromJson(Map<String, dynamic> parsedJson) {
    return Respuestas(
      iD: parsedJson['ID'],
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