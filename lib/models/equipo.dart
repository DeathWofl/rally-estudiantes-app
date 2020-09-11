import 'package:hive/hive.dart';

part 'equipo.g.dart';

@HiveType(typeId: 0)
class Equipo {
  
  // int iD;
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

  Equipo({/*this.iD,*/ this.matriculaE1, this.matriculaE2, this.matriculaE3, this.codigoGrupo, this.contraGrupo, this.apiID});

  factory Equipo.fromJson(Map<String, dynamic> parsedJson) {
    return Equipo(
      // iD: parsedJson['ID'],
      matriculaE1: parsedJson['matriculaE1'],
      matriculaE2: parsedJson['matriculaE2'],
      matriculaE3: parsedJson['matriculaE3'],
      codigoGrupo: parsedJson['CodigoGrupo'],
      contraGrupo: parsedJson['ContraGrupo'],
      apiID: parsedJson['ID'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      // 'id': iD,
      'matriculaE1': matriculaE1,
      'matriculaE2': matriculaE2,
      'matriculaE3': matriculaE3,
      'codigoGrupo': codigoGrupo,
      'contraGrupo': contraGrupo,
      'apiID': apiID
    };
  }

  Equipo.fromMap(Map<String, dynamic> map) {
    // iD = map['id'];
    matriculaE1 = map['matriculaE1'];
    matriculaE2 = map['matriculaE2'];
    matriculaE3 = map['matriculaE3'];
    codigoGrupo = map['codigoGrupo'];
    contraGrupo = map['contraGrupo'];
    apiID = map['apiID'];
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