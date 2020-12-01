import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/body.dart';
import 'package:flutter/services.dart';

class Welcome extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    //Zoptymalizować czas ładowania tła
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        image: AssetImage('assets/ekran_glowny_tlo.png'),
        child: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  /*
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed:  () {
                              print('click');
                            },
                            color: Colors.orange,
                            child: Text(
                              "Pomiń".toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            )
                        ),
                      )
                    ) 
                  ),
                  */
                  Center(
                    child: Container(
                      width: size.width,
                      height: size.height*0.6,
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/Planus.png"),
                        SizedBox(height: size.height*0.15),
                        RoundedButton(
                          width: size.width*0.7,
                          text: "Zaloguj się",
                          onPress: (){
                            //jakos to zmienic
                            //Navigator.pushReplacementNamed(context, '/login');
                            Navigator.pushNamed(context, '/login');
                          },
                          color: Colors.orange.withOpacity(0.95),
                        ),
                        RoundedButton(
                          width: size.width*0.7,
                          text: "Zarejestruj się",
                          onPress: (){
                            //jakos to zmienic
                            //Navigator.pushReplacementNamed(context, '/register');
                            Navigator.pushNamed(context, '/register');
                          },
                          color: Colors.orange.withOpacity(0.95),
                        ),
                      ]
                  ),
                    ),
                  ),
              ]),
            ),
        ),
      ),
    );
  }
}

