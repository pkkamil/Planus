import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/circlePerson.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';

class FlatScreen extends StatelessWidget {
  
  final FlatInfo flatData;

  FlatScreen(this.flatData);

  //wyliczanie dni od aktualnej daty
  int days = 5;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height*0.07),
            Text(
              flatData.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.orange,
                fontSize: 26
              ),
            ),
            Text(
              flatData.localization,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              width: size.width*0.6,
              height: size.width*0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(flatData.image),
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
            Text(
              "Pozostały okres rozliczeniowy:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 18,
              ),
            ),
            Text(
              (flatData.billing_period==1) ? 'miesiąc' : flatData.billing_period.toString()+" miesiące",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.orange,
                fontSize: 18,
              ),
            ),
            SizedBox(height: size.height*0.03),
            if(days!=0)Text(
              "Do terminu rozliczenia",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 18,
              ),
            ),
            if(days!=0)RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 18,
                ),
                children: [
                  TextSpan(text: "pozostało "),
                  TextSpan(text: days.toString(), style: TextStyle(color: Colors.orange)),
                  TextSpan(text: " dni."),
                ]
              ),
            ),
            if(days==0)RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 18,
                ),
                children: [
                  TextSpan(text: "Dziś ", style: TextStyle(color: Colors.orange)),
                  TextSpan(text: "wypada termin rozliczenia."),
                ]
              ),
            ),
            SizedBox(height: size.height*0.03),
            if(days!=0)RoundedButton(
              horizontal: 40.0,
              text: "Wprowadź liczniki",
              onPress: () {
              },
              isShadow: false,
            ),
            if(days==0)RoundedButton(
              horizontal: 40.0,
              text: "Wprowadź liczniki",
              onPress: () {
                //Dodać id apartment
                Navigator.pushNamed(context, "/insertCounters");
              },
              isShadow: false,
              textColor: Colors.orange,
              color: Colors.white,
            ),
            SizedBox(height: size.height*0.05),
            Container(
              width: size.width*0.7,
              child: Text(
                "Mieszkańcy",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              width: size.width*0.75,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                  child: Row(
                  children: [
                    PersonCircle(size: size, name: "User1"),
                    PersonCircle(size: size, name: "User2"),
                    PersonCircle(size: size, name: "User3"),
                    PersonCircle(size: size, name: "User4"),
                    AddPersonCircle(size: size,)
                  ]
                ),
              ),
            ),
            SizedBox(height: size.height*0.1,)
          ],
        ),
      ),
    );
  }
}