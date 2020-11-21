import 'package:flutter/material.dart';
import 'dart:math';

class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(text: "Rachunek za "),
                          TextSpan(text: "mieszkanie", style: TextStyle(color: Colors.orange)),
                        ]
                      ),
                    ),
                    Text(
                      "Termin rozliczeniowy: 10.11",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 18,
                ),
                children: [
                  TextSpan(text: "Łączna suma rachunku ".toUpperCase(), style: TextStyle(color: Colors.orange)),
                  TextSpan(text: 3370.toString()),
                  TextSpan(text: " ZŁ".toUpperCase(), style: TextStyle(color: Colors.grey[600])),
                  ]
                ),
              ),
              Container(
                width: size.width*0.9,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                width: size.width*0.6,
                height: size.width*0.6,
                decoration: BoxDecoration(
                  color: Colors.red
                ),
              ),
              Container(
                width: size.width*0.9,
                alignment: Alignment.centerLeft,
                child: RichText(
                text: TextSpan(
                  style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 24,
                ),
                children: [
                  TextSpan(text: "Szczegóły "),
                  TextSpan(text: "rachunku ", style: TextStyle(color: Colors.orange)),
                  ]
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
