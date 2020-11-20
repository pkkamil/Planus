import 'package:flutter/material.dart';
import 'package:planus/components/circlePerson.dart';

class ResidentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    String kod = "xyz123qwe";

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
          children:[ 
          Container(
          child: Stack(
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
                      TextSpan(text: "Dodaj "),
                      TextSpan(text: "mieszkańców", style: TextStyle(color: Colors.orange)),
                    ]
                  ),
                )
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.15),
                    Container(
                      width: size.width*0.7,
                      child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(text: "Aby dodać nowych mieszkańców, udostępnij swój "),
                          TextSpan(text: "kod zaproszenia", style: TextStyle(color: Colors.orange)),
                        ]
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.03),
                    Container(
                      width: size.width*0.7,
                      child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(text: "Kod zaproszenia: "),
                          TextSpan(text: kod, style: TextStyle(color: Colors.orange)),
                        ]
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.05),
                    Text(
                      "Lub".toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 24
                      ),
                    ),
                    SizedBox(height: size.height*0.05),
                    Container(
                      width: size.width*0.7,
                      child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(text: "Udostępnij swój "),
                          TextSpan(text: "kod QR", style: TextStyle(color: Colors.orange)),
                        ]
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.03),
                    Image.asset("assets/sampleQR.png"),
                  ],
                ),
              )
            ]
          ),
        ),
        SizedBox(height: size.height*0.03),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 24,
              ),
              children: [
                TextSpan(text: "Oczekujący "),
                TextSpan(text: "mieszkańcy", style: TextStyle(color: Colors.orange)),
              ]
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 0),
          alignment: Alignment.centerLeft,
          width: size.width*0.9,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,                
            child: Row(
              children: [
                PersonCircle(size: size, name: "User1"),
                PersonCircle(size: size, name: "User2"),
                PersonCircle(size: size, name: "User3"),
                PersonCircle(size: size, name: "User4"),
              ]
            ),
          ),
        ),
        ]
      ),
    );
  }
}