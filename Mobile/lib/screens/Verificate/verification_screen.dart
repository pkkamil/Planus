import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:planus/services/adresses.dart';


class Verificate extends StatefulWidget {

  final String email;
  Verificate(this.email);

  @override
  _VerificateState createState() => _VerificateState();
}

var code;

class _VerificateState extends State<Verificate> {


  @override
  void initState() {
    _getCode(widget.email);
  }

  _getCode(String email) async{
    try{
      Response response = await post("$api_adress/verify", body: {'email':email});
      Map data = jsonDecode(response.body);

      setState((){
        code = data['code'];
        print(code);
      });
    }
    catch (e){
      print("Wystąpił błąd");
    }
  }

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
              /*
              RoundedButton(
                text:"Wyślij ponownie",
                onPress: () {},
                width: size.width*0.7,
              )
              */
              RoundedInput(
                width: size.width*0.7,
                icon: Icons.vpn_key,
                placeholder: "Twój klucz",
                iconColor: Colors.grey[900],
                onChanged: (val) {
                  if(val==code.toString()){
                    //dodanie do bazy danych
                    Navigator.pushReplacementNamed(context, '/flats');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}