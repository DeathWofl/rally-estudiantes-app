import 'package:flutter/material.dart';

class Finish extends StatelessWidget {
  const Finish({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rally Terminado"),
        centerTitle: true,
        leading: Icon(null),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Felicidades!! 🥳🥳🥳🥳",
              style: TextStyle(
                fontSize: 24
              ),
            ),
            FlatButton(
              onPressed: () => print("234"),
              child: Text(
                "Terminar",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}