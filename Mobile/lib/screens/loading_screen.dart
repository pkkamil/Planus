import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:planus/services/adresses.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void checkConnection() async {
    try{
      Response response = await get("$api_adress");
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
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  @override
  void initState() {
    super.initState();
    setupWelcomeScreen();
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