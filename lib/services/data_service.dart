import 'package:estudiantes/models/equipo.dart';
import 'package:estudiantes/models/pregunta.dart';
import 'package:estudiantes/models/respuestas.dart';
import 'package:estudiantes/utils/server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:hive/hive.dart';

class DataService {

  static String personalCodigoGrupo;

  Future<int> getEquipos() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');

      var uri = Uri.http(Server.URL, "/api/app/equipo");
      var response = await Server.client.get(uri, headers: {
        'Authorization': 'Bearer $token',
      } );

      print("Get Equipos: ${response.statusCode}");

      var decode = json.decode(response.body);
      EquipoList equipos = EquipoList.fromJson(decode);

      Box<Equipo> boxequipos = Hive.box<Equipo>('equipos');
      boxequipos.clear();

      for (var item in equipos.equipo) {
        boxequipos.add(item);
      }

      return response.statusCode;
    } catch (e) {
      print(e);
    }
  } 

  Future<int> getPreguntas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');

      var uri = Uri.http(Server.URL, "/api/app/preguntas");
      var response = await Server.client.get(uri, headers: {
        'Authorization': 'Bearer $token',
      } );

      print("Get Preguntas: ${response.statusCode}");

      var decode = json.decode(response.body);
      PreguntaList preguntas = PreguntaList.fromJson(decode);

      Box<Pregunta> boxpreguntas = Hive.box<Pregunta>('preguntas');
      boxpreguntas.clear();

      for (var item in preguntas.pregunta) {
        boxpreguntas.add(item);
      }

      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }

  Future<int> getRespuestas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');

      var uri = Uri.http(Server.URL, "/api/app/respuestas");
      var response = await Server.client.get(uri, headers: {
        'Authorization': 'Bearer $token',
      } );

      print("Get Respuestas: ${response.statusCode}");

      var decode = json.decode(response.body);
      ListRespuestas respuestas = ListRespuestas.fromJson(decode);

      Box<Respuestas> boxrespuestas = Hive.box<Respuestas>('respuestas');
      boxrespuestas.clear();

      for (var item in respuestas.respuesta) {
        boxrespuestas.add(item);
      }

      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }

}