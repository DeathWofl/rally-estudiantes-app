class Equipo {
  
  final int iD;
  final String matriculaE1;
	final String matriculaE2;
	final String matriculaE3;
	final String codigoGrupo;
	final String contraGrupo;

  Equipo({this.iD, this.matriculaE1, this.matriculaE2, this.matriculaE3, this.codigoGrupo, this.contraGrupo});

  factory Equipo.fromJson(Map<String, dynamic> parsedJson) {
    return Equipo(
      iD: parsedJson['ID'],
      matriculaE1: parsedJson['matriculaE1'],
      matriculaE2: parsedJson['matriculaE2'],
      matriculaE3: parsedJson['matriculaE3'],
      codigoGrupo: parsedJson['CodigoGrupo'],
      contraGrupo: parsedJson['ContraGrupo'],
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