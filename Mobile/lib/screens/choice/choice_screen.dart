import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/screens/Flat/AddFlat/AddFlat_screen.dart';
import 'package:planus/screens/Flat/AddingResident/JoinFlat_screen.dart';

class Choice extends StatelessWidget {
  final int user_id;
  Choice(this.user_id);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height*0.15),
              SvgPicture.asset(
                "assets/Decide.svg",
                width: size.width*0.6,
              ),
              SizedBox(height: size.height*0.05),
              Text(
                "Co chcesz zrobić?",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 24
                ),
              ),
              SizedBox(height: size.height*0.05),
              RoundedButton(
                text:"Utwórz mieszkanie",
                onPress: () {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => AddFlat(user_id)));
                  //Navigator.pushNamed(context, '/addFlat');
                },
                fontsize: 17.0,
                width: size.width*0.7,
              ),
              SizedBox(height: size.height*0.03),
              RoundedButton(
                text:"Dołącz do mieszkania",
                fontsize: 17.0,
                onPress: () {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => JoinFlat(user_id)));
                },
                width: size.width*0.7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}