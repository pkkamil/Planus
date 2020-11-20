import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: size.height*0.07),
            RoundedButton(
              text: "Zmiana imienia",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
                Navigator.pushNamed(context, '/changeName');
              },
            ),
            RoundedButton(
              text: "Zmiana hasła",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
                Navigator.pushNamed(context, '/changePassword');
              },
            ),
            RoundedButton(
              text: "Zmiana adresu e-mail",
              width: size.width*0.7,
              horizontal: 10.0,
              vertical: 15.0,
              onPress: () {
                Navigator.pushNamed(context, '/changeEmail');
              },
            ),
            RoundedButton(
              text: "Edytuj mieszkanie",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
                //Navigator.pushNamed(context, '/deleteFlat');
              },
            ),
            RoundedButton(
              text: "Usuń mieszkanie",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
                Navigator.pushNamed(context, '/deleteFlat');
              },
            ),
            RoundedButton(
              text: "Usuń konto",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
                Navigator.pushNamed(context, '/deleteAccount');
              },
            ),
            RoundedButton(
              text: "Wyloguj",
              width: size.width*0.7,
              vertical: 15.0,
              onPress: () {
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