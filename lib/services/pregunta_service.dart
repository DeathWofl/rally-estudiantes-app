import 'package:estudiantes/utils/db_helper.dart';

import 'auth_service.dart';
import 'package:estudiantes/utils/server.dart';
import 'package:estudiantes/models/pregunta.dart';

import 'dart:convert';

class PreguntaService {
  
  Future getAllPregunta() async {
    try {
      
      var uri = Uri.http(Server.URL, "/api/app/preguntas");
      var response = await Server.client.get(uri, headers: Server.getHeader(Auth.Token));

      var decode = json.decode(response.body);
      PreguntaList preguntaList = PreguntaList.fromJson(decode);

      print("Pregunta Service: ${response.statusCode}");
      print("Response Body, Pregunta Service: $decode");
      
      for (var item in preguntaList.pregunta) {
        DBHelper.instance.savePregunta(Pregunta(
          preg: item.preg,
          apiID: item.apiID,
          estacionID: item.estacionID,
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}