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

class ChangePassword extends StatelessWidget {

  final FlatInfo flatData;

  ChangePassword(this.flatData);

  final newPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose(){
    newPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
          child: Container(
            width: size.width,
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
                          SizedBox(height: size.height*0.1),
                          SvgPicture.asset(
                            "assets/ChangePassword.svg",
                            width: size.width*0.6,
                          ),
                          SizedBox(height:size.height*0.03),
                          RoundedInput(
                            controller: passwordController,
                            width: size.width*0.7,
                            placeholder: "Obecne hasło",
                            password: true,
                            icon: Icons.lock,
                            color: Colors.white,
                            textColor: Colors.black,
                            iconColor: Colors.black,
                          ),
                          RoundedInput(
                            controller: newPasswordController,
                            width: size.width*0.7,
                            placeholder: "Hasło",
                            password: true,
                            color: Colors.white,
                            textColor: Colors.black,
                            iconColor: Colors.black,
                            icon: Icons.lock,
                          ),
                          RoundedInput(
                            controller: confirmPasswordController,
                            width: size.width*0.7,
                            placeholder: "Potwierdź hasło",
                            password: true,
                            color: Colors.white,
                            textColor: Colors.black,
                            iconColor: Colors.black,
                            icon: Icons.lock,
                          ),
                          SizedBox(height: size.height*0.05),
                          RoundedButton(
                            text: "Zmień hasło",
                            textColor: Colors.white,
                            color: Colors.orange.withOpacity(0.95),
                            onPress: () async{
                              if(newPasswordController.text.length>=8 && passwordController.text.length>=8 && confirmPasswordController.text.length>=8){
                                if(newPasswordController.text!=confirmPasswordController.text){
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                    backgroundColor: Colors.orange,
                                    content: Text(
                                      'Hasła się nie zgadzają',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                      )
                                    )
                                  );
                                }else{
                                  Map data = {
                                  'user_id': flatData.id_user,
                                  'current_password': passwordController.text,
                                  'new_password': newPasswordController.text,
                                  'confirm_password': confirmPasswordController.text,
                                  };
                                  
                                  var api = new Api();
                                  var response = await api.changePassword(data);
                                  //print(response);
                                  if(response['Message']=='OK'){
                                    SharedPreferences localStorage = await SharedPreferences.getInstance();
                                    Map userData = jsonDecode(localStorage.getString('userData'));
                                    
                                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(userData)));
                                  }else{
                                    _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                    backgroundColor: Colors.orange,
                                    content: Text(
                                      'Niepoprawne hasło',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                      )
                                    )
                                  );
                                  }
                                }
                              }else{
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                  backgroundColor: Colors.orange,
                                  content: Text(
                                    'Hasło powinno mieć minimum 8 znaków',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                    )
                                  )
                                );
                              }
                            },
                            width: size.width*0.7
                          ),
                          SizedBox(height: size.height*0.03),
                        ],
                    ),
                )]
            ),
          ),
      ),
    );
  }
}