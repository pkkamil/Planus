import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/body.dart';

class Welcome extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    //Zoptymalizować czas ładowania tła
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        image: AssetImage('assets/ekran_glowny_tlo.png'),
        child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/Planus.png"),
              SizedBox(height: size.height*0.2),
              RoundedButton(
                width: size.width*0.7,
                text: "Zaloguj się",
                onPress: (){
                  Navigator.pushNamed(context, '/login');
                },
                color: Colors.orange.withOpacity(0.95),
              ),
              RoundedButton(
                width: size.width*0.7,
                text: "Zarejestruj się",
                onPress: (){
                  Navigator.pushNamed(context, '/register');
                },
                color: Colors.orange.withOpacity(0.95),
              ),
              SizedBox(height: size.height*0.1)
            ]
          ),
        ),
      ),
    );
  }
}

