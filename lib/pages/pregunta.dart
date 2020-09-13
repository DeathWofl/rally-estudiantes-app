import 'package:estudiantes/models/pregunta.dart';
import 'package:estudiantes/models/regRespuestas.dart';
import 'package:estudiantes/models/respuestas.dart';
import 'package:estudiantes/models/equipo.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'finish.dart';
import 'package:estudiantes/services/data_service.dart';

class Preguntas extends StatefulWidget {
  const Preguntas({Key key}) : super(key: key);

  @override
  _PreguntasState createState() => _PreguntasState();
}

class _PreguntasState extends State<Preguntas> {
  int currentIndex = 0;
  int max;
  List<Pregunta> pregs;
  List<Respuestas> resp;
  Respuestas selectedResp;

  @override
  void initState() {
    super.initState();
    pregs = Hive.box<Pregunta>('preguntas').values.toList();
    max = Hive.box<Pregunta>('preguntas').values.length;
    resp = Hive.box<Respuestas>("respuestas")
        .values
        .where((element) => element.preguntaID == pregs[currentIndex].apiID)
        .toList();
  }

  setSelectedRadio(Respuestas respuestas) {
    setState(() {
      selectedResp = respuestas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preguntas"),
        centerTitle: true,
        leading: Icon(null),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                pregs[currentIndex].preg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    RadioListTile(
                      value: resp[0],
                      title: Text(resp[0].resp),
                      groupValue: selectedResp,
                      onChanged: (val) => setSelectedRadio(val),
                    ),
                    RadioListTile(
                      value: resp[1],
                      title: Text(resp[1].resp),
                      groupValue: selectedResp,
                      onChanged: (val) => setSelectedRadio(val),
                    ),
                    RadioListTile(
                      value: resp[2],
                      title: Text(resp[2].resp),
                      groupValue: selectedResp,
                      onChanged: (val) => setSelectedRadio(val),
                    ),
                    RadioListTile(
                      value: resp[3],
                      title: Text(resp[3].resp),
                      groupValue: selectedResp,
                      onChanged: (val) => setSelectedRadio(val),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: FlatButton(
                  onPressed: () => next(),
                  child: Text(
                    "Proxima",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void next() {
    setState(() {
      currentIndex++;
    });
    if (currentIndex >= (max-1)) {
      Hive.box<RegRespuestas>('regrespuestas').add(RegRespuestas(
        calificacion: selectedResp.valor,
        preguntaID: pregs[currentIndex].apiID,
        equipoID: Hive.box<Equipo>('equipos').values.where((element) => element.codigoGrupo == DataService.personalCodigoGrupo).first.apiID,
      ));
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Finish()));
    } else {
      resp = Hive.box<Respuestas>("respuestas")
        .values
        .where((element) => element.preguntaID == pregs[currentIndex].apiID)
        .toList();
      Hive.box<RegRespuestas>('regrespuestas').add(RegRespuestas(
        calificacion: selectedResp.valor,
        preguntaID: pregs[currentIndex].apiID,
        equipoID: Hive.box<Equipo>('equipos').values.where((element) => element.codigoGrupo == DataService.personalCodigoGrupo).first.apiID,
      ));
    }
  }
}
