import 'package:estudiantes/models/respuestas.dart';

class RegRespuestas {
  
  int id;
  int preguntaID;
	int calificacion;
	int equipoID;

  RegRespuestas({this.id,this.preguntaID, this.calificacion, this.equipoID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'id': id,
      'preguntaID': preguntaID,
      'calificacion': calificacion,
      'equipoID': equipoID,
    };
  }

  RegRespuestas.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    preguntaID = map['preguntaID'];
    calificacion = map['calificacion'];
    equipoID = map['equipoID'];
  }

}