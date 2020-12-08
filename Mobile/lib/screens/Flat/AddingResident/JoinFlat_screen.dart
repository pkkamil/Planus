import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_scan/barcode_scan.dart';

class JoinFlat extends StatefulWidget {
  final int user_id;
  JoinFlat(this.user_id);

  @override
  _JoinFlatState createState() => _JoinFlatState();
}

class _JoinFlatState extends State<JoinFlat> {
  String code;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                        onChanged: (val) {
                          code = val;
                        },
                      ),
                      RoundedButton(
                        text: "Dołącz",
                        vertical: 15.0,
                        horizontal: 50.0,
                        onPress: () async {
                          var api = new Api();
                          Map data = {
                            'user_id': widget.user_id,
                            'code': code
                          };
                          var response = await api.joinFlat(data);

                          if(response['message']=='OK'){
                            SharedPreferences localStorage = await SharedPreferences.getInstance();
                            Map response = jsonDecode(localStorage.getString('userData'));

                            Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
                          }
                        },
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
                      InkWell(
                        onTap: () async {

                          String codeScanner = await BarcodeScanner.scan();
                          
                          var api = new Api();
                          Map data = {
                            'user_id': widget.user_id,
                            'code': codeScanner
                          };
                          var response = await api.joinFlat(data);

                          if(response['message']=='OK'){
                            SharedPreferences localStorage = await SharedPreferences.getInstance();
                            Map response = jsonDecode(localStorage.getString('userData'));

                            Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
                          }
                        },
                        
                        child: Container(
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
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}