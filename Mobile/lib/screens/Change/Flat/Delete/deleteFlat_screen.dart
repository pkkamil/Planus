import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';

class DeleteFlat extends StatelessWidget {

  final String flat_name;
  final String image;

  const DeleteFlat({
    Key key,
    this.image = "assets/mieszkanie.png",
    this.flat_name = "Osiedle\nfranciszkańskie",
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
                children: [
                  GoBackButton(
                    pop: true,
                  ),
                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height*0.05),
                          Text(
                            flat_name.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 26
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                            width: size.width*0.6,
                            height: size.width*0.6,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(image),
                                fit: BoxFit.cover
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height:size.height*0.03),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 24,
                              ),
                              children: [
                                TextSpan(text: "Próbujesz "),
                                TextSpan(text: "usunąć\n", style: TextStyle(color: Colors.red)),
                                TextSpan(text: "swoje "),
                                TextSpan(text: "mieszkanie", style: TextStyle(color: Colors.orange)),
                                TextSpan(text: "."),
                              ]
                            ),
                          ),
                          Text(
                            "Czy jesteś pewny?",
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 18
                            ),
                          ),
                          SizedBox(height: size.height*0.03),
                          RoundedButton(
                            horizontal: 0.0,
                            text: "Tak, usuń mieszkanie",
                            color: Colors.orange.withOpacity(0.95),
                            textColor: Colors.white,
                            onPress: (){
                              Navigator.popAndPushNamed(context, '/flats');
                            },
                            width: size.width*0.7
                          ),             
                        ],
                    ),
                )]
            ),
          ),
      ),
    );
  }
}