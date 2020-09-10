import 'package:estudiantes/models/regRespuestas.dart';
import 'package:estudiantes/utils/db_helper.dart';
import 'package:flutter/material.dart';

class Probando extends StatefulWidget {
  Probando({Key key}) : super(key: key);

  @override
  _ProbandoState createState() => _ProbandoState();
}

class _ProbandoState extends State<Probando> {

  List<RegRespuestas> regs;

  @override
  void initState() { 
    super.initState();
    initData();
  }

  initData() async {
    regs = await DBHelper.instance.getAllRegRespuesta();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: regs.length,
        itemBuilder: (context, index) {
          return Text(regs[index].calificacion.toString());
        },
      ),
    );
  }
}