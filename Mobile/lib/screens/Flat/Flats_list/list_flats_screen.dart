import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planus/components/AddFlatCard.dart';
import 'package:planus/components/FlatCard.dart';
import 'package:planus/components/RoundedButton.dart';

class ListFlats extends StatelessWidget {
  
  final String name;
  final flats_count;
  final String image;
  final String flat_name;
  final font_size;
  final marginL,marginT,marginR,marginB;

  const ListFlats({
    this.name = "Radosław",
    this.flats_count = 4,
    this.image = "assets/mieszkanie.png",
    this.flat_name = "Osiedle franciszkańskie",
    this.font_size = 16.0,
    this.marginL= 10.0,
    this.marginT= 10.0,
    this.marginR= 10.0,
    this.marginB= 10.0,
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
          body: Container(
            height: size.height,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 24,
                      ),
                      children: [
                        TextSpan(text: "Twoje "),
                        TextSpan(text: "mieszkania", style: TextStyle(color: Colors.orange)),
                        TextSpan(text: ":"),
                      ]
                    ),
                  )
                ),
                /*
                Center(
                  child: SingleChildScrollView(
                      child: Column(
                      children: [
                        SizedBox(height: size.height*0.0001),
                        ListWidgets(flats_count,size,image,font_size,marginL,marginT,marginR,marginB),
                        if(flats_count%2==1) Row(
                            children: [
                              FlatCard(
                                //flat_name: flat_name, 
                                flat_name: flats_count-1, 
                                size: size.width*0.4, 
                                image: image,
                                fontSize: font_size,
                                marginL: marginL,
                                marginT: marginT,
                                marginR: marginR,
                                marginB: marginB
                              ),
                              AddFlatCard(
                                size: size.width*0.4,
                                marginL: marginL,
                                marginT: marginT,
                                marginR: marginR,
                                marginB: marginB
                              ),
                            ],
                          ),
                        if(flats_count%2==0)RoundedButton(
                          width: size.width*0.7,
                          marginH: marginL,
                          marginV: marginT,
                          onPress: () {
                          },
                          text: "Dodaj mieszkanie",
                        )
                      ],
                    ),
                  ),
                )
                */
              ],
            ),
          ),
    );
  }
}