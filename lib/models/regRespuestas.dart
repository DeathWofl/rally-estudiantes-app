import 'package:estudiantes/models/respuestas.dart';

class RegRespuestas {
  
  final int preguntaID;
	final int calificacion;
	final int equipoID;

  RegRespuestas({this.preguntaID, this.calificacion, this.equipoID});

  factory RegRespuestas.fromJson(Map<String, dynamic> parsedJson) {
    return RegRespuestas(
      preguntaID: parsedJson['PreguntaID'],
      calificacion: parsedJson['Calificacion'],
      equipoID: parsedJson['EquipoID'],
    );
  }
}

class ListRegRespuestas {
  
  final List<RegRespuestas> respuesta;
  ListRegRespuestas({this.respuesta});

  factory ListRegRespuestas.fromJson(List<dynamic> parsedJson) {
    List<RegRespuestas> respuestas = List<RegRespuestas>();
    respuestas = parsedJson.map((e) => RegRespuestas.fromJson(e)).toList();

    return ListRegRespuestas(respuesta: respuestas);
  }
}