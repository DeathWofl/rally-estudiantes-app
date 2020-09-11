import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_service.dart';
import 'package:estudiantes/utils/server.dart';


class Auth {

  static Future<int> signIn(String username, String password) async {
    try {
      var uri = Uri.http(Server.URL, "/api/loginalumnos");
      var response = await Server.client.post(uri, body: {
        "MatriculaE1": username,
	      "ContraGrupo": password
      });

      print("Auth Service: ${response.statusCode}");

      Map<String, dynamic> decode = json.decode(response.body);
      String token = decode['token'];
      EquipoService.personalCodigoGrupo = decode['CodigoGrupo'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }


}