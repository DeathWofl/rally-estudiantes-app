import 'package:flutter/material.dart';
import 'pregunta.dart';
import 'qr.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget _currentPage;
  List<Widget> _listPages = List();
  int _currentIndex = 0;

  @override
  void initState() { 
    super.initState();
    
    _listPages..add(Preguntas())..add(QR());
    _currentPage = Preguntas();
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listPages[selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromRGBO(50, 104, 214, 1),
        onTap: (value) => _changePage(value),
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesome.question),
            title: Text('Preguntas')
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome.qrcode),
            title: Text('QR')
          )
        ]
      ),
    );
  }
}