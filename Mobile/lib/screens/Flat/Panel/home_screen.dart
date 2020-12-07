import 'package:flutter/material.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/screens/Flat/Panel/screens/flat.dart';
import 'package:planus/screens/Flat/Panel/screens/graphs.dart';
import 'package:planus/screens/Flat/Panel/screens/payments.dart';
import 'package:planus/screens/Flat/Panel/screens/residents.dart';
import 'package:planus/screens/Flat/Panel/screens/settings.dart';

class Home extends StatefulWidget {

  final FlatInfo flatData;

  Home(this.flatData);

  //final owner = true;
  bool owner = false;

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  Widget _body;
  int _currentIndex = 0;

  void selectScreen(int x, bool owner){
    if(owner){
      switch(x){
        case 0:
          _body = FlatScreen(widget.flatData);
          break;
        case 1:
          _body = ResidentsScreen(widget.flatData);
          break;
        case 2:
          _body = PaymentsScreen(widget.flatData);
          break;
        case 3:
          _body = GraphsScreen(widget.flatData);
          break;
        case 4:
          _body = SettingsScreen(widget.flatData);
          break;
      }
    }else{
      switch(x){
        case 0:
          _body = FlatScreen(widget.flatData);
          break;
        case 1:
          _body = PaymentsScreen(widget.flatData);
          break;
        case 2:
          _body = GraphsScreen(widget.flatData);
          break;
        case 3:
          _body = SettingsScreen(widget.flatData);
          break;
      }
    }

  }


  @override
  void initState() {
    super.initState();
    setState(() {
      widget.owner = widget.flatData.id_owner == widget.flatData.id_user;
    });
    selectScreen(_currentIndex,widget.owner);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: _body,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.orange[600], width: 2.0))),
          child: BottomNavigationBar(
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
              label: "Podsumowanie",
              backgroundColor: Colors.orange,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: "Statystyki",
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
                Navigator.pop(context);
              }
              selectScreen(_currentIndex,widget.owner);
            });
          },
        ),
      ),
    );
  }
}

