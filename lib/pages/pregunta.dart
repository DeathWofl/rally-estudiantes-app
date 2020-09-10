import 'dart:async';

import 'package:estudiantes/models/regRespuestas.dart';
import 'package:estudiantes/models/respuestas.dart';
import 'package:estudiantes/pages/finish.dart';
import 'package:estudiantes/services/equipo_service.dart';
import 'package:estudiantes/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:estudiantes/models/pregunta.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preguntas extends StatefulWidget {
  const Preguntas({Key key}) : super(key: key);

  @override
  _PreguntasState createState() => _PreguntasState();
}

class _PreguntasState extends State<Preguntas> {
  int currentPreg = 0;
  Respuestas selectedRespuesta;
  Pregunta currentPregunta;
  int maxPreg;
  String option = "";

  @override
  void initState() {
    setConfigs();
    super.initState();
  }

  setConfigs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getInt("currentpreg") == null)
      await preferences.setInt("currentpreg", 0);
    await preferences.setInt("currentpreg", 0);
    currentPreg = preferences.getInt("currentpreg");
    await DBHelper.instance.initDB();
  }

  setSelectedRadio(Respuestas val) {
    setState(() {
      selectedRespuesta = val;
    });
  }

  Future<List<Respuestas>> anwers(int preguntaid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.getInt("currentpreg");
    List<Pregunta> ques = await DBHelper.instance.getAllPregunta();
    List<Respuestas> ans = await DBHelper.instance.getRespuesta(ques[preguntaid].apiID);
    print(id);
    print(ques[preguntaid].apiID);
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preguntas"),
        centerTitle: true,
        leading: Icon(null),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: <Widget>[
            FutureBuilder(
                future: 
                  DBHelper.instance.getAllPregunta().then((value) {
                    currentPregunta = value[currentPreg];
                    maxPreg = value.length;
                    return value;
                  }),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return LoadingResp();
                  return Column(
                    children: <Widget>[
                      Text(
                        snapshot.data[currentPreg].preg,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                }),
            FutureBuilder(
              future: anwers(currentPreg),
              builder: (context, snapshot){
                if (!snapshot.hasData) return LoadingResp();
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("A."),
                              RadioListTile(
                                title: Text(snapshot.data[0].resp),
                                value: snapshot.data[0],
                                groupValue: selectedRespuesta,
                                onChanged: (val) {
                                  option = "A";
                                  setSelectedRadio(val);
                                },
                                selected: selectedRespuesta == snapshot.data[0]
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("B."),
                              RadioListTile(
                                title: Text(snapshot.data[1].resp),
                                value: snapshot.data[1],
                                groupValue: selectedRespuesta,
                                onChanged: (val) {
                                  option = "B";
                                  setSelectedRadio(val);
                                },
                                selected: selectedRespuesta == snapshot.data[1]
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("C."),
                              RadioListTile(
                                title: Text(snapshot.data[2].resp),
                                value: snapshot.data[2],
                                groupValue: selectedRespuesta,
                                onChanged: (val) {
                                  option = "C";
                                  setSelectedRadio(val);
                                },
                                selected: selectedRespuesta == snapshot.data[2]
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("D."),
                              RadioListTile(
                                title: Text(snapshot.data[3].resp),
                                value: snapshot.data[3],
                                groupValue: selectedRespuesta,
                                onChanged: (val) {
                                  option = "D";
                                  setSelectedRadio(val);
                                },
                                selected: selectedRespuesta == snapshot.data[3]
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
            Text("Seleccionado: $option"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: IconButton(
                  color: Colors.black,
                  icon: Icon(MaterialCommunityIcons.arrow_right_thick,
                      size: 48, color: Colors.grey),
                  onPressed: () => changeQuestion()),
            )
          ],
        ),
      ),
    );
  }

  changeQuestion() async {
    setState(() {
      currentPreg++;
      print("Current Preg: $currentPreg");
    });
    if(currentPreg > maxPreg) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Finish()));
      });
    }
    else {
    DBHelper.instance.saveRegRespuesta(RegRespuestas(
      preguntaID: currentPregunta.id,
      calificacion: selectedRespuesta.valor,
      equipoID: await DBHelper.instance.dataEquipo(EquipoService.personalCodigoGrupo)
    ));
    print("Prueba de equipo ID");
    print(await DBHelper.instance.dataEquipo(EquipoService.personalCodigoGrupo));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("currentpreg",  currentPreg);
    }
  }

}

class LoadingResp extends StatelessWidget {
  const LoadingResp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
      );
  }
}
