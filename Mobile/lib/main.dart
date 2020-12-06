import 'package:flutter/material.dart';
import 'package:planus/screens/Change/Account/deleteAccount_screen.dart';
import 'package:planus/screens/Change/Account/farawell.dart';
import 'package:planus/screens/Change/Flat/Delete/deleteFlat_screen.dart';
import 'package:planus/screens/Change/Introduce/ChangeName_screen.dart';
import 'package:planus/screens/Change/Password/changePassword_screen.dart';
import 'package:planus/screens/Change/email/ChangeEmail_screen.dart';
import 'package:planus/screens/Flat/AddingResident/JoinFlat_screen.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/screens/Flat/Flats_list/list_flats_screen.dart';
import 'package:planus/screens/Flat/Panel/home_screen.dart';
import 'package:planus/screens/Flat/Panel/screens/Counters/InsertCounters_screen.dart';
import 'package:planus/screens/Introduce/introduce_screen.dart';
import 'package:planus/screens/Verificate/verification_screen.dart';
import 'package:planus/screens/choice/choice_screen.dart';
import 'package:planus/screens/loading_screen.dart';
import 'package:planus/screens/Welcome/welcome_screen.dart';
import 'package:planus/screens/Login/login_screen.dart';
import 'package:planus/screens/Register/register_screen.dart';
import 'package:planus/screens/Remind/remind_screen.dart';

import 'screens/Flat/AddFlat/AddFlat_screen.dart';

Map data = {
  'id':0,
  'name':'Disconnected'
};
List example;
FlatInfo flatInfo;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(), //Loading
      '/welcome': (context) => Welcome(),
      '/login': (context) => Login(),
      '/register': (context) => Register(),
      '/remind': (context) => Remind(),
      '/introduce': (context) => Introduce(),
      '/flats':(context) => Flats(data),
      '/listflats':(context) => ListFlats(example),
      '/home': (context) => Home(flatInfo),
      '/verificate': (context) => Verificate('',''),
      '/choice': (context) => Choice(1),
      '/changeName': (context) => ChangeName(flatInfo),
      '/changeEmail': (context) => ChangeEmail(flatInfo),
      '/deleteAccount': (context) => DeleteAccount(flatInfo),
      '/changePassword': (context) => ChangePassword(flatInfo),
      '/farawell': (context) => Farawell(),
      '/deleteFlat':(context) => DeleteFlat(flatInfo),
      '/addFlat': (context) => AddFlat(1),
      '/joinFlat': (context) => JoinFlat(1),
      '/insertCounters': (context) => InsertCounters(1,1)
    }
  ));
}