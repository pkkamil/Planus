import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _LoadingState extends State<Loading> {

  void checkConnection() async {
    try{
      Response response = await get("$api");
      if(response.statusCode==200){
        setupWelcomeScreen();
      }
    }
    catch(e){
      //Dodać snackBar
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.orange,
              content: Text(
                'Brak połączenia z internetem',
                 textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18
                ),
              )
          )
        );
      print("Wystąpił błąd");
    }
  }

  void setupWelcomeScreen() async{
    await Future.delayed(Duration(seconds: 1));
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userData = localStorage.getString('userData');

    //print('######');
    //print(userData);
    //print('######');

    if(userData==null){
      Navigator.pushReplacementNamed(context, '/welcome');
    }else{
      Map response = jsonDecode(userData);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
    }
  }

  @override
  void initState() {
    super.initState();
    //setupWelcomeScreen();
    checkConnection();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.orange,
      body: Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 100.0,
        ),
      )
    );
  }
}