import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteFlat extends StatelessWidget {

  final FlatInfo flatData;

  DeleteFlat(this.flatData);



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
                            flatData.name.toUpperCase(),
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
                            onPress: () async{
                              Map data = {
                                'user_id': flatData.id_user,
                                'id_apartment': flatData.id_apartment
                              };
                              print(data);
                              var api = new Api();
                              var response = await api.deleteFlat(data);
                              print(response);
                              if(response['message']=='OK'){
                                  SharedPreferences localStorage = await SharedPreferences.getInstance();
                                  Map userData = jsonDecode(localStorage.getString('userData'));
                                  
                                  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(userData)));
                              }
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