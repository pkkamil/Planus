import 'package:flutter/material.dart';

class GraphsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                  width: size.width*0.9,
                  alignment: Alignment.centerLeft,
                  child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 24,
                  ),
                  children: [
                    TextSpan(text: "Statystki "),
                    TextSpan(text: "mieszkania ", style: TextStyle(color: Colors.orange)),
                    ]
                  ),
                ),
                ),
                Container(
                  width: size.width*0.7,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(text: "Wysokość rachunku ", style: TextStyle(color: Colors.orange)),
                          TextSpan(text: "mieszkania \nw ciągu ostatnich 12 miesięcy"),
                          ]
                        ),
                      ),
                      Container(
                        width: size.width*0.8,
                        height: size.width*0.7,
                        decoration: BoxDecoration(
                          color: Colors.black
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}