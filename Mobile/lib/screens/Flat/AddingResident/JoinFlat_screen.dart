import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/goBackButton.dart';

class JoinFlat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
            child: Stack(
            children: [
              GoBackButton(
                isLeft: false,
                pop: true,
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height:size.height*0.15),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(text: "Dołącz do "),
                          TextSpan(text: "mieszkania", style: TextStyle(color: Colors.orange)),
                        ]
                      )
                    ),
                    SizedBox(height:size.height*0.05),
                    RoundedInput(
                      width: size.width*0.7,
                      icon: Icons.group,
                      placeholder: "Kod zaproszenia",
                      iconColor: Colors.grey[900],
                    ),
                    RoundedButton(
                      text: "Dołącz",
                      vertical: 15.0,
                      horizontal: 50.0,
                    ),
                    SizedBox(height:size.height*0.03),
                    Text(
                      "Lub".toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 24
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
                          TextSpan(text: "Zeskanuj "),
                          TextSpan(text: "kod QR", style: TextStyle(color: Colors.orange)),
                        ]
                      )
                    ),
                    SizedBox(height:size.height*0.03),
                    Container(
                      width: size.width*0.6,
                      height: size.width*0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.orange
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 150,
                        color: Colors.white,
                      ),
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