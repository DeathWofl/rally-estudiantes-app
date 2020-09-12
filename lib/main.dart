import 'package:estudiantes/models/equipo.dart';
import 'package:estudiantes/models/pregunta.dart';
import 'package:estudiantes/models/regRespuestas.dart';
import 'package:estudiantes/models/respuestas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/login.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(EquipoAdapter());
  Hive.registerAdapter(PreguntaAdapter());
  Hive.registerAdapter(RegRespuestasAdapter());
  Hive.registerAdapter(RespuestasAdapter());
  await Hive.openBox<Equipo>('equipos');
  await Hive.openBox<Pregunta>('preguntas');
  await Hive.openBox<Respuestas>('respuestas');
  await Hive.openBox<RegRespuestas>('regrespuestas');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rally Estudiantes',
      theme: ThemeData(
        // primarySwatch: Color.fromRGBO(50, 104, 214, 1),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}

