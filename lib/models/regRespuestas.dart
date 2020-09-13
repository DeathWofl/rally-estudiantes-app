import 'package:hive/hive.dart';

part 'regRespuestas.g.dart';

@HiveType(typeId: 3)
class RegRespuestas {
  
  @HiveField(0)
  int preguntaID;
  @HiveField(1)
	int calificacion;
  @HiveField(2)
	int equipoID;

  RegRespuestas({this.preguntaID, this.calificacion, this.equipoID});

  Map<String, dynamic> toJson() => {
    'PreguntaID':preguntaID,
    'Calificacion':calificacion,
    'EquipoID':equipoID
  };

}