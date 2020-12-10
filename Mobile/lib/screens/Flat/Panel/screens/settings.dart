import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/screens/Change/Account/deleteAccount_screen.dart';
import 'package:planus/screens/Change/Flat/Delete/deleteFlat_screen.dart';
import 'package:planus/screens/Change/Introduce/ChangeName_screen.dart';
import 'package:planus/screens/Change/Password/changePassword_screen.dart';
import 'package:planus/screens/Change/email/ChangeEmail_screen.dart';
import 'package:planus/screens/Flat/EditFlat/EditFlat_screen.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {

  final FlatInfo flatData;

  SettingsScreen(this.flatData);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: size.height*0.05),
            RoundedButton(
              text: "Zmiana imienia",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => ChangeName(flatData)));
              },
            ),
            RoundedButton(
              text: "Zmiana hasła",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => ChangePassword(flatData)));
              },
            ),
            RoundedButton(
              text: "Zmiana e-mail",
              width: size.width*0.7,
              horizontal: 10.0,
              vertical: 15.0,
              onPress: () {
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => ChangeEmail(flatData)));
              },
            ),
            if(flatData.id_owner==flatData.id_user)RoundedButton(
              horizontal: 0.0,
              text: "Edytuj mieszkanie",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => EditFlat(flatData)));
              },
            ),
            if(flatData.id_owner==flatData.id_user)RoundedButton(
              horizontal: 0.0,
              text: "Usuń mieszkanie",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => DeleteFlat(flatData)));
              },
            ),
            if(flatData.id_owner!=flatData.id_user)RoundedButton(
              horizontal: 0.0,
              text: "Opuść mieszkanie",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () async{
                Map data = {
                  'member_id': flatData.id_user,
                  'user_id': flatData.id_owner,
                  'id_apartment': flatData.id_apartment
                };
                print(data);
                var api = new Api();
                var response = await api.kickMember(data);

                print(response);

                if(response['message']=='OK'){
                  SharedPreferences localStorage = await SharedPreferences.getInstance();
                  Map response = jsonDecode(localStorage.getString('userData'));

                  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
                }
              },
            ),
            RoundedButton(
              text: "Usuń konto",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => DeleteAccount(flatData)));
              },
            ),
            RoundedButton(
              text: "Wyloguj",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () async{
                SharedPreferences localStorage = await SharedPreferences.getInstance();
                localStorage.setString('userData', null);
                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                Navigator.pushNamed(context, '/welcome');
              },
            ),
            SizedBox(height: size.height*0.05),
            Text(
              "Aplikacja stworzona przez",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[900]
              ),
            ),
            Text(
              "Radosława Rajda",
              style: TextStyle(
                fontSize: 18,
                color: Colors.orange
              ),
            ),
            SizedBox(height: size.height*0.1)
          ],
        ),
      ),
    );
  }
}