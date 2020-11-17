import 'package:flutter/material.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/screens/Flat/Flats_list/list_flats_screen.dart';
import 'package:planus/screens/Introduce/introduce_screen.dart';
import 'package:planus/screens/loading_screen.dart';
import 'package:planus/screens/Welcome/welcome_screen.dart';
import 'package:planus/screens/Login/login_screen.dart';
import 'package:planus/screens/Register/register_screen.dart';
import 'package:planus/screens/Remind/remind_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/welcome': (context) => Welcome(),
      '/login': (context) => Login(),
      '/register': (context) => Register(),
      '/remind': (context) => Remind(),
      '/introduce': (context) => Introduce(),
      '/flats':(context) => Flats(),
      '/listflats':(context) => ListFlats()
    }
  ));
}