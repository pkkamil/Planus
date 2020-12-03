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

class _LoadingState extends State<Loading> {

  void checkConnection() async {
    try{
      Response response = await get("$secondApi");
      Map data = jsonDecode(response.body);
      if(data['message']=='OK'){
        setupWelcomeScreen();
      }
    }
    catch(e){
      print("Wystąpił błąd");
    }
  }

  void setupWelcomeScreen() async{
    await Future.delayed(Duration(seconds: 1));
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userData = localStorage.getString('userData');

    print('######');
    print(userData);
    print('######');

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
    checkConnection();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
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