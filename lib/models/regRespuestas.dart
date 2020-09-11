import 'package:estudiantes/models/respuestas.dart';
import 'package:hive/hive.dart';

part 'regRespuestas.g.dart';

@HiveType(typeId: 3)
class RegRespuestas {
  
  // int id;
  @HiveField(0)
  int preguntaID;
  @HiveField(1)
	int calificacion;
  @HiveField(2)
	int equipoID;

  RegRespuestas({/*this.id,*/this.preguntaID, this.calificacion, this.equipoID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      // 'id': id,
      'preguntaID': preguntaID,
      'calificacion': calificacion,
      'equipoID': equipoID,
    };
  }

  RegRespuestas.fromMap(Map<String, dynamic> map) {
    // id = map['id'];
    preguntaID = map['preguntaID'];
    calificacion = map['calificacion'];
    equipoID = map['equipoID'];
  }

}