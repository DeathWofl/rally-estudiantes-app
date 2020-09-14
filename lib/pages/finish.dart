import 'package:estudiantes/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class Finish extends StatelessWidget {
  const Finish({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terminado"),
        centerTitle: true,
        leading: Icon(null),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  "Felicidades 🥳🥳🥳",
                  style: TextStyle(fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FlatButton(
                      onPressed: () => send(context),
                      child: Text(
                        "Terminar",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  void send(BuildContext context) async {
    var connectityresult = await Connectivity().checkConnectivity();
    DataService dataService = DataService();

    if (connectityresult == ConnectivityResult.none) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Advertencia."),
            content: Text("Es necesario conexion a internet."),
            actions: [FlatButton(onPressed: null, child: Text("Ok"))],
          );
        },
      );
    } else {
      dataService.postRegRespuesta();
      return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Gracias."),
            content: Text("Gracias por concluir el proceso, puede cerrar la app.."),
            actions: [FlatButton(onPressed:() => Navigator.of(context).pop(), child: Text("Ok"))],
          );
        },
      );
    }
  }
}
