import 'package:estudiantes/models/respuestas.dart';
import 'package:estudiantes/utils/db_helper.dart';
import 'package:estudiantes/utils/server.dart';
import 'auth_service.dart';

import 'dart:convert';

class RespuestaService {
  
  Future getAllRespuesta() async {
    try {
      
      var uri = Uri.http(Server.URL, "/api/app/respuestas");
      var response = await Server.client.get(uri, headers: Server.getHeader(Auth.Token));
      
      var decode = json.decode(response.body);
      ListRespuestas respuestas = ListRespuestas.fromJson(decode);

      print("Respuesta Service: ${response.statusCode}");
      print("Response Body, Pregunta Respuesta: $decode");
      for (var item in respuestas.respuesta) {
        DBHelper.instance.saveRespuesta(Respuestas(
          resp: item.resp,
          valor: item.valor,
          preguntaID: item.preguntaID,
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}