import 'package:estudiantes/models/equipo.dart';
import 'package:estudiantes/utils/db_helper.dart';
import 'package:estudiantes/utils/server.dart';
import 'auth_service.dart';

import 'dart:convert';


class EquipoService {

  static String personalCodigoGrupo;

  Future getAllEquipos() async {
    try {
      
      var uri = Uri.http(Server.URL, "/api/app/equipo");
      var response = await Server.client.get(uri, headers: Server.getHeader(Auth.Token));
      
      var decode = json.decode(response.body);
      EquipoList equipoList = EquipoList.fromJson(decode);

      print("Pregunta Equipo: ${response.statusCode}");
      print("Response Body, Pregunta Equipo: $decode");

      for (var item in equipoList.equipo) {
        DBHelper.instance.saveEquipo(Equipo(
          iD: item.iD,
          matriculaE1: item.matriculaE1,
          matriculaE2: item.matriculaE2,
          matriculaE3: item.matriculaE3,
          codigoGrupo: item.codigoGrupo,
          contraGrupo: item.contraGrupo
        ));
      }
    } catch (e) {
      print(e);
    }
  }
  
}