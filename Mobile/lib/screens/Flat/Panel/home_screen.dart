import 'package:flutter/material.dart';
import 'package:planus/screens/Flat/Panel/screens/flat.dart';
import 'package:planus/screens/Flat/Panel/screens/graphs.dart';
import 'package:planus/screens/Flat/Panel/screens/payments.dart';
import 'package:planus/screens/Flat/Panel/screens/residents.dart';
import 'package:planus/screens/Flat/Panel/screens/settings.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class Home extends StatefulWidget {

  final bool owner;

  const Home({
    Key key,
    this.owner = true,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _body;
  int _currentIndex = 0;

  void selectScreen(int x){
    switch(x){
      case 0:
        _body = FlatScreen();
        break;
      case 1:
        _body = ResidentsScreen();
        break;
      case 2:
        _body = PaymentsScreen();
        break;
      case 3:
        _body = GraphsScreen();
        break;
      case 4:
        _body = SettingsScreen();
        break;
    }
  }


  @override
  void initState() {
    super.initState();
    selectScreen(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        iconSize: 35,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Mieszkanie",
            backgroundColor: Colors.orange,
          ),
          if(widget.owner) BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Mieszkańcy",
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: "Płatności",
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: "Wykresy",
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Ustawienia",
            backgroundColor: Colors.orange,
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if(_currentIndex==0){
              Navigator.popAndPushNamed(context, 'flats');
            }
            selectScreen(_currentIndex);
          });
        },
      ),
    );
  }
}

