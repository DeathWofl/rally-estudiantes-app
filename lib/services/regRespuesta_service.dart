import 'dart:convert';

import 'package:estudiantes/models/regRespuestas.dart';
import 'package:estudiantes/utils/server.dart';
import 'auth_service.dart';

class RegRespuestaService {
  
  Future sendRegRespuesta(List<RegRespuestas> regs) async {
    try {
      var uri = Uri.http(Server.URL, "/api/app/regrespuesta");
      for (var item in regs) {
        var response = await Server.client.post(uri, headers: Server.getHeader(Auth.Token), body: jsonEncode(item));
        print(response.statusCode);
      }
      
    } catch (e) {
      print(e);
    }
  }
}