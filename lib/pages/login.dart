import 'package:flutter/material.dart';

import 'package:estudiantes/widgets/form.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.5), BlendMode.dstATop),
            ),
            color: Colors.black
          ),
          child: SafeArea(
            child: Container(
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Color.fromRGBO(167, 233, 175, 1),
                        fontSize: 30,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.0),
                      child: LoginFormWidget(),
                    )
                  ],
                ),
              ),
            )
          )
        ),
      ),
    );
  }
}

