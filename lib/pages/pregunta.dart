import 'package:flutter/material.dart';

class Preguntas extends StatelessWidget {
  const Preguntas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Text('Preguntas'),
        ),
      )
    );
  }
}