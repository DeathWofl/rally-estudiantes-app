import 'dart:io';

import 'package:estudiantes/services/auth_service.dart';
import 'package:estudiantes/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:estudiantes/pages/home.dart';
import 'package:estudiantes/services/equipo_service.dart';
import 'package:estudiantes/services/pregunta_service.dart';
import 'package:estudiantes/services/respuesta_service.dart';

class LoginFormWidget extends StatefulWidget {
  LoginFormWidget({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormWidget> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  String _password;
  String _username;

  EquipoService equipoService;
  PreguntaService preguntaService;
  RespuestaService respuestaService;

  @override
  void initState() { 
    equipoService = EquipoService();
    preguntaService = PreguntaService();
    respuestaService = RespuestaService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Form(
          key: _formGlobalKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              //First TextField
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: TextFormField(
                  initialValue: '2016-0001',
                  validator: (value) => _validateUsername(value),
                  onSaved: (newValue) => _username = newValue,
                  maxLength: 9,
                  style: TextStyle(color: Color.fromRGBO(50, 104, 214, 1)),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'xxxx-xxxx',
                      prefixIcon: Icon(MaterialCommunityIcons.account_badge,
                          color: Color.fromRGBO(106, 190, 139, 1)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 3,
                            color: Color.fromRGBO(106, 140, 175, 1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 3,
                            color: Color.fromRGBO(106, 190, 139, 1)),
                      )),
                ),
              ),
              //Second Text Field
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: TextFormField(
                  initialValue: 'Pass123',
                  validator: (value) => _validatePassword(value),
                  onSaved: (newValue) {
                    _password = newValue;
                  },
                  obscureText: true,
                  style: TextStyle(color: Color.fromRGBO(50, 104, 214, 1)),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '•••••••••',
                      prefixIcon: Icon(MaterialCommunityIcons.lock,
                          color: Color.fromRGBO(106, 190, 139, 1)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 3,
                            color: Color.fromRGBO(106, 140, 175, 1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 3,
                            color: Color.fromRGBO(106, 190, 139, 1)),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                child: RaisedButton(
                  onPressed: () => _submitData(context),
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: MediaQuery.of(context).size.width / 4),
                  color: Color.fromRGBO(167, 233, 175, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  migrateAndLogin(BuildContext _context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("first", false);
    await Auth.signIn(_username, _password) == 200
      ? downloadData(context)
      : problem(context, "Usuario o contraseña incorrecta.");
    print('Descargando datos');
  }

  downloadData(BuildContext context) async {
    await DBHelper.instance.initDB();
    DBHelper.instance.onmigrate();
    await preguntaService.getAllPregunta();
    await respuestaService.getAllRespuesta();
    await equipoService.getAllEquipos().whenComplete(() => ok(context));
  }

  loginOffline(BuildContext _context) async {
    DBHelper dbEquipo;
    var equipo = await dbEquipo.login(_username);
    if (equipo.contraGrupo == _password) ok(context);
    else problem(context, "Usuario o contraseña incorrecto");
  }

  String _validatePassword(String value) {
    return value.isEmpty ? 'Es necesario llenar este campo' : null;
  }

  String _validateUsername(String value) {
    return value.isEmpty ? 'Es Necesario LLenar este campo' : null;
  }

  void _submitData(BuildContext context) async {
    if (_formGlobalKey.currentState.validate()) {
      _formGlobalKey.currentState.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getBool("first") == null
        ? prefs.setBool("first", true)
        : prefs.setBool("first", false);
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (prefs.getBool("first")) {
        // mobile data
        if (connectivityResult == ConnectivityResult.mobile) {
          AlertDialog(
            title: Text("Seguro?"),
            content: Text(
                "Esta utilizando datos moviles para descargar los datos, desea continuar?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () =>
                      Platform.isAndroid ? SystemNavigator.pop() : exit(0),
                  child: Text("No")),
              FlatButton(onPressed: migrateAndLogin(context), child: Text("Si"))
            ],
          );
          // wifi
        } else if (connectivityResult == ConnectivityResult.wifi) {
          print("migrando");
          migrateAndLogin(context);
        }
        else {
          AlertDialog(
                title: Text("Problema"),
                content: Text(
                    "Es necesario conexion a internet la primera vez que se loguea, para la descarga de datos"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () =>
                          Platform.isAndroid ? SystemNavigator.pop() : exit(0),
                      child: Text("Ok")),
                ],
              );
        }
      } else {
        if (connectivityResult == ConnectivityResult.wifi) {
          migrateAndLogin(context);
        } else {
          loginOffline(context);
        }
      }
    }
  }

  void ok(BuildContext context) {
    final greenSnackbar = SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: <Widget>[
            Icon(MaterialCommunityIcons.check_bold),
            SizedBox(width: 10),
            Text('Bienvenido')
          ],
        ));
    Scaffold.of(context).showSnackBar(greenSnackbar);

    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  void problem(BuildContext context, String text) {
    final redSnackbar = SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(MaterialCommunityIcons.alert_circle),
            SizedBox(width: 10),
            Text(text)
          ],
        ));
    Scaffold.of(context).showSnackBar(redSnackbar);
  }
}
