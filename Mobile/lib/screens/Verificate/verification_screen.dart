import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:http/http.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'dart:convert';

import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Verificate extends StatefulWidget {

  final String email;
  final String password;
  Verificate(this.email, this.password);

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
      Response response = await post("$secondApi/verify", body: {'email':email});
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


  sendData(data) async{
      var api = new Api();
      var response = await api.login(data);
      
      if(response['email'].toLowerCase()==data['email'].toLowerCase()){
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('userData', jsonEncode(response));

        Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
      }else{
        print(response['message']);
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
                    
                    Map data = {
                      'email': widget.email,
                      'password': widget.password
                    };

                    sendData(data);
                }}
              )
            ],
          ),
        ),
      ),
    );
  }
}