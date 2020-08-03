import 'dart:convert';
import 'dart:async';
import 'equipo_service.dart';
import 'package:estudiantes/utils/server.dart';


class Auth {
  
  static String Token;

  static Future<int> signIn(String username, String password) async {
    try {
      var uri = Uri.http(Server.URL, "/api/loginalumnos");
      var response = await Server.client.post(uri, body: {
        "MatriculaE1": username,
	      "ContraGrupo": password
      });

      print(response.statusCode);
      Map<String, dynamic> decode = json.decode(response.body);
      Token = decode['token'];
      EquipoService.personalCodigoGrupo = decode['CodigoGrupo'];

      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }


}