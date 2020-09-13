import 'package:estudiantes/models/regRespuestas.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Prueba extends StatelessWidget {
  const Prueba({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prueba"),
        centerTitle: true,
        leading: Icon(null),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<RegRespuestas>('regrespuestas').listenable(),
        builder: (context, Box<RegRespuestas> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text("No hay registros"),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              RegRespuestas currentReg = box.getAt(index);
              return ListTile(
                leading: Text(currentReg.preguntaID.toString()),
                title: Text(currentReg.calificacion.toString()),
                subtitle: Text(currentReg.equipoID.toString()),
              );
            }
          );
        }
      ),
    );
  }
}