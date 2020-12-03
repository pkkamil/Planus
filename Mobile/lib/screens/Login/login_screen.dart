import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    sendData(data) async{

      var api = new Api();
      var response = await api.login(data);

      if(response['email']==null){
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            'Podano błędne dane logowania',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18
            ),
            )
          )
        );
      }

      try{
        if(response['email'].toLowerCase()==data['email'].toLowerCase()){

          //Jezeli nie ma zweryfikowanego maila popandpushnamed do verificate
          SharedPreferences localStorage = await SharedPreferences.getInstance();
          localStorage.setString('userData', jsonEncode(response));
          
          Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));


        }else{
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orange,
              content: Text(
                "Musisz wypełnić wszystkie pola",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18
                ),
              )
            )
          );
        }
      }catch(e){
        print(e);
      }
    }
        
    
  
    
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) { return SingleChildScrollView(
            child: Container(
              height: size.height,
                child: Stack(
                  children: [
                    GoBackButton(),
                    Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height*0.1),
                            SvgPicture.asset(
                              "assets/Login.svg",
                              width: size.width*0.4,
                              height: size.height*0.2,
                            ),
                            SizedBox(height: size.height*0.03),
                            Text(
                              "Witaj z powrotem",
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 24
                              ),
                            ),
                            SizedBox(height:size.height*0.05),
                            RoundedInput(
                              controller: emailController,
                              width: size.width*0.7,
                              placeholder: "E-mail",
                              color: Colors.white,
                              textColor: Colors.black,
                              iconColor: Colors.black,
                            ),
                            RoundedInput(
                              controller: passwordController,
                              width: size.width*0.7,
                              placeholder: "Hasło",
                              password: true,
                              color: Colors.white,
                              textColor: Colors.black,
                              iconColor: Colors.black,
                              icon: Icons.lock,
                            ),
                            SizedBox(height: size.height*0.05),
                            RoundedButton(
                              text: "Zaloguj się",
                              color: Colors.orange.withOpacity(0.95),
                              textColor: Colors.white,
                              onPress: (){
                                if(emailController.text == '' || passwordController.text ==''){
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.orange,
                                      content: Text(
                                        "Musisz wypełnić wszystkie pola",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18
                                      ),
                                    )
                                  )
                                  );
                                }else{
                                  Map data = {
                                    'email': emailController.text,
                                    'password': passwordController.text
                                  };
                                  sendData(data);
                                }
                                
                                
                              },
                              width: size.width*0.7
                            ),
                            SizedBox(height: size.height*0.03),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/remind');
                              },
                              child: Text(
                                  "Zapomniałeś hasła?",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 20
                                ),
                              ),
                            )
                      
                          ],
                      ),
                  )]
              ),
            ),
        );}
      ),
    );
  }
}
