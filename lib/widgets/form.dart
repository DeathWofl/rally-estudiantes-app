import 'package:connectivity/connectivity.dart';
import 'package:estudiantes/models/equipo.dart';
import 'package:estudiantes/models/pregunta.dart';
import 'package:estudiantes/models/respuestas.dart';
import 'package:estudiantes/services/auth_service.dart';
import 'package:estudiantes/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

import 'package:estudiantes/pages/home.dart';

class LoginFormWidget extends StatefulWidget {
  LoginFormWidget({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormWidget> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  String _password;
  String _username;

  DataService dataService;

  @override
  void initState() { 
    super.initState();
    dataService = DataService();
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
                    style: TextStyle(  
                      color: Color.fromRGBO(50, 104, 214, 1)
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'xxxx-xxxx',
                      prefixIcon: Icon(MaterialCommunityIcons.account_badge, color: Color.fromRGBO(106, 190, 139, 1)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 3,
                          color: Color.fromRGBO(106, 140, 175, 1)
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 3,
                          color: Color.fromRGBO(106, 190, 139, 1)
                        ),
                      )
                    ),
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
                    style: TextStyle(  
                      color: Color.fromRGBO(50, 104, 214, 1)
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '•••••••••',
                      prefixIcon: Icon(MaterialCommunityIcons.lock, color: Color.fromRGBO(106, 190, 139, 1)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 3,
                          color: Color.fromRGBO(106, 140, 175, 1)
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 3,
                          color: Color.fromRGBO(106, 190, 139, 1)
                        ),
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                  child: RaisedButton(
                    onPressed: () => _submitData(context),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: MediaQuery.of(context).size.width / 4),
                    color: Color.fromRGBO(167, 233, 175, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }

  String _validatePassword(String value) {
    return value.isEmpty ? 'Es necesario llenar este campo' : null; 
  }

  String _validateUsername(String value) {
    return value.isEmpty ? 'Es Necesario LLenar este campo' : null ;
  }

  void migrateAndLogin(BuildContext _context) async {

    // logearse
    int code = await AuthService.signIn(_username, _password);

    if (code != 200) {
      snack(
        context: context,
        title: "Se ha producido un error",
        icon: Icon(MaterialCommunityIcons.alert_circle),
        color: Colors.red
      );
    }
    else{

    // trayendo datos de la API
    Hive.box<Equipo>("equipos").clear();
    Hive.box<Pregunta>("preguntas").clear();
    Hive.box<Respuestas>("respuestas").clear();
    await dataService.getEquipos();
    await dataService.getPreguntas();
    await dataService.getRespuestas();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("first", false);

    snack(
      context: context,
      title: "Bienvenido con Migracion.",
      color: Colors.green,
      icon: Icon(MaterialCommunityIcons.check_bold),    
    );

    // pasar a la proxima pagina
    Future.delayed(Duration(seconds: 5), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
    }
  }

  void loginOffline(BuildContext _context) async {

    bool code = await AuthService.login(_username, _password);

   if(code) {
    snack(
      context: context,
      title: "Bienvenido Offline",
      color: Colors.green,
      icon: Icon(MaterialCommunityIcons.check_bold),
    );

    // pasar a la proxima pagina
    Future.delayed(Duration(seconds: 5), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
   }
   else
    snack(
      context: context,
      title: "Ha ocurrido un error.",
      color: Colors.red,
      icon: Icon(MaterialCommunityIcons.alert_circle),
    );
  }

  void _submitData(BuildContext context) async {
    if (_formGlobalKey.currentState.validate()) {
      _formGlobalKey.currentState.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      // revisar conexion
      var connectityresult = await Connectivity().checkConnectivity();

      // configurando first en caso de que no exista
      if (prefs.getBool("first") == null) await prefs.setBool("first", true);

      if (prefs.getBool("first")) {
        if (connectityresult == ConnectivityResult.none) {
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Advertencia."),
                content: Text("Es necesario conexion a internet."), 
                actions: [
                  FlatButton(onPressed: null, child: Text("Ok"))
                ],
              );
            },
          );
        }
        return migrateAndLogin(context);
      }
      else {
        if (connectityresult == ConnectivityResult.none) {
          return loginOffline(context);
        }
        else if(connectityresult == ConnectivityResult.mobile) {
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                // title: Text("Advertencia."),
                content: Text("Esta utilizando datos mobiles, desea utilizarlos para el proceso."),
                actions: [
                  FlatButton(
                    onPressed: () => loginOffline(context),
                    child: Text("No")
                  ),
                  FlatButton(
                    onPressed: () => migrateAndLogin(context),
                    child: Text("Ok")
                  ),
                ],
              );
            },
          );
        }
        else {
          migrateAndLogin(context);
        }
      }
    }
  }

  void snack({BuildContext context,String title, Icon icon, Color color}) {
    final snackbar = SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: <Widget>[
            icon,
            SizedBox(width: 10),
            Text(title)
          ],
        )
      );
    Scaffold.of(context).showSnackBar(snackbar);
  }

}
