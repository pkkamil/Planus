import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';

class Verificate extends StatefulWidget {
  @override
  _VerificateState createState() => _VerificateState();
}

class _VerificateState extends State<Verificate> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height*0.2),
              SvgPicture.asset(
                "assets/Verified.svg",
                width: size.width*0.6,
              ),
              SizedBox(height: size.height*0.05),
              Text(
                "Zweryfikuj e-mail",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 24
                ),
              ),
              SizedBox(height: size.height*0.05),
              RoundedButton(
                text:"Wyślij ponownie",
                onPress: () {},
                width: size.width*0.7,
              )
            ],
          ),
        ),
      ),
    );
  }
}