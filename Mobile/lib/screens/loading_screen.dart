import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

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