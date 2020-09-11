import 'package:estudiantes/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() { 
    validateFirst();
    super.initState();
  }

  validateFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool("first") == null ? prefs.setBool("first", true) : prefs.setBool("first", false);
  }

  void migrateAndLogin(BuildContext _context) async {
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text('Logueado con Migracion'),
      backgroundColor: Colors.lightGreen,
    ));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("first", false);
  }

  void loginOffline(BuildContext _context) async {
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text('Logueado Offline'),
      backgroundColor: Colors.lightGreen,
    ));
    // SharedPreferences prefs = await SharedPreferences.getInstance(); 
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

  void _submitData(BuildContext context) async {
    if (_formGlobalKey.currentState.validate()) {
      _formGlobalKey.currentState.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getBool("first") ? migrateAndLogin(context) : loginOffline(context);

      // final redSnackbar = SnackBar(
      //   duration: Duration(seconds: 3),
      //   backgroundColor: Colors.red,
      //   behavior: SnackBarBehavior.floating,
      //   content: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     children: <Widget>[
      //       Icon(MaterialCommunityIcons.alert_circle),
      //       SizedBox(width: 10),
      //       Text('Usuario o Contraseña incorrecta')
      //     ],
      //   )
      // );

      // await Auth.signIn(_username, _password) == 200 ? ok(context) : Scaffold.of(context).showSnackBar(redSnackbar);
      // print('Enviado');
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
        )
      );
    Scaffold.of(context).showSnackBar(greenSnackbar);

    Future.delayed(Duration(seconds: 5), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

}
