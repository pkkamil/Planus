import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planus/components/AddFlatCard.dart';
import 'package:planus/components/FlatCard.dart';
import 'package:planus/components/RoundedButton.dart';

class Flats extends StatelessWidget {
  
  final String name;
  final flats_count;
  final String image;
  final String flat_name;

  const Flats({
    this.name = "Radosław",
    this.flats_count = 3,
    this.image = "assets/mieszkanie.png",
    this.flat_name = "Osiedle franciszkańskie",
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 50,
                    left: 30,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(text: "Witaj, "),
                          TextSpan(text: name, style: TextStyle(color: Colors.orange)),
                          TextSpan(text: "!"),
                        ]
                      ),
                    )
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height*0.1),
                        FlatCard(
                          flat_name: flat_name, 
                          size: size.width*0.5, 
                          image: image
                        ),
                        if(flats_count>1) FlatCard(
                          flat_name: flat_name, 
                          size: size.width*0.5, 
                          image: image
                        ),
                        if(flats_count==1) AddFlatCard(
                          size: size.width*0.5
                        ),
                        if(flats_count==2)RoundedButton(
                          width: size.width*0.7,
                          onPress: () {},
                          text: "Dodaj mieszkanie",
                        ),
                        if(flats_count>2)RoundedButton(
                          width: size.width*0.7,
                          color: Colors.white,
                          textColor: Colors.orange,
                          onPress: () {
                            Navigator.popAndPushNamed(context, '/listflats');
                          },
                          text: "Zobacz wszystkie",
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
