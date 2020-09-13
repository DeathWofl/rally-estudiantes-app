import 'package:hive/hive.dart';

part 'equipo.g.dart';

@HiveType(typeId: 0)
class Equipo {
  
  @HiveField(0)
  String matriculaE1;
  @HiveField(1)
	String matriculaE2;
  @HiveField(2)
	String matriculaE3;
  @HiveField(3)
	String codigoGrupo;
  @HiveField(4)
	String contraGrupo;
  @HiveField(5)
  int apiID;

  Equipo({this.matriculaE1, this.matriculaE2, this.matriculaE3, this.codigoGrupo, this.contraGrupo, this.apiID});

  factory Equipo.fromJson(Map<String, dynamic> parsedJson) {
    return Equipo(
      matriculaE1: parsedJson['matriculaE1'],
      matriculaE2: parsedJson['matriculaE2'],
      matriculaE3: parsedJson['matriculaE3'],
      codigoGrupo: parsedJson['CodigoGrupo'],
      contraGrupo: parsedJson['ContraGrupo'],
      apiID: parsedJson['ID'],
    );
  }

}

class EquipoList {
  final List<Equipo> equipo;
  EquipoList({this.equipo});
  
  factory EquipoList.fromJson(List<dynamic> jsonParsed) {
    List<Equipo> equipos = List<Equipo>();
    equipos = jsonParsed.map((e) => Equipo.fromJson(e)).toList();

    return EquipoList(equipo: equipos);
  }
}