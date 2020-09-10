class Equipo {
  
  int iD;
  String matriculaE1;
	String matriculaE2;
	String matriculaE3;
	String codigoGrupo;
	String contraGrupo;
  int aPIID;

  Equipo({this.iD, this.matriculaE1, this.matriculaE2, this.matriculaE3, this.codigoGrupo, this.contraGrupo, this.aPIID});

  factory Equipo.fromJson(Map<String, dynamic> parsedJson) {
    return Equipo(
      aPIID: parsedJson['ID'],
      matriculaE1: parsedJson['matriculaE1'],
      matriculaE2: parsedJson['matriculaE2'],
      matriculaE3: parsedJson['matriculaE3'],
      codigoGrupo: parsedJson['CodigoGrupo'],
      contraGrupo: parsedJson['ContraGrupo'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'id': iD,
      'matriculaE1': matriculaE1,
      'matriculaE2': matriculaE2,
      'matriculaE3': matriculaE3,
      'codigoGrupo': codigoGrupo,
      'contraGrupo': contraGrupo,
      'aPIID': aPIID
    };
    return map;
  }

  Equipo.fromMap(Map<String, dynamic> map) {
    iD = map['id'];
    aPIID = map['APIID'];
    matriculaE1 = map['matriculaE1'];
    matriculaE2 = map['matriculaE2'];
    matriculaE3 = map['matriculaE3'];
    codigoGrupo = map['codigoGrupo'];
    contraGrupo = map['contraGrupo'];
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