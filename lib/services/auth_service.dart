import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'data_service.dart';
import 'package:estudiantes/utils/server.dart';
import 'package:estudiantes/models/equipo.dart';


class AuthService {

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
      DataService.personalCodigoGrupo = decode['CodigoGrupo'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> login(String username, String password) async {

    Box<Equipo> equipobox = Hive.box<Equipo>('equipos');
    Equipo equipo = equipobox.values.where((user) => user.matriculaE1 == username || user.matriculaE2 == username || user.matriculaE3 == username).first;

    if(equipo.matriculaE1 == username || equipo.matriculaE2 == username || equipo.matriculaE3 == username && equipo.contraGrupo == password) return true;
    return false;
  }


}