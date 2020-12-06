import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeEmail extends StatelessWidget {

  final FlatInfo flatData;

  ChangeEmail(this.flatData);

  final emailController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose(){
    emailController.dispose();
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
                            "assets/Email.svg",
                            width: size.width*0.6,
                          ),
                          SizedBox(height:size.height*0.03),
                          Text(
                            "Zmień pocztę",
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 24
                            ),
                          ),
                          SizedBox(height:size.height*0.05),
                          RoundedInput(
                            controller: emailController,
                            width: size.width*0.7,
                            icon: Icons.email,
                            placeholder: "Nowy adres e-mail",
                            color: Colors.white,
                            textColor: Colors.black,
                            iconColor: Colors.black,
                          ),
                          SizedBox(height: size.height*0.05),
                          RoundedButton(
                            text: "Zmień adres e-mail",
                            color: Colors.orange.withOpacity(0.95),
                            textColor: Colors.white,
                            onPress: () async{
                              if(emailController.text!=null && emailController.text.length>0){
                                if(!EmailValidator.validate(emailController.text)){
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                    backgroundColor: Colors.orange,
                                    content: Text(
                                      'Niepoprawny adres e-mail',
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
                                  'email': emailController.text
                                  };
                                  
                                  var api = new Api();
                                  var response = await api.changeEmail(data);
                                  
                                  SharedPreferences localStorage = await SharedPreferences.getInstance();
                                  Map userData = jsonDecode(localStorage.getString('userData'));

                                  //print(response);
                                  
                                  
                                  if(response['Message']=='OK'){
                                    userData['email'] = emailController.text;
                                    localStorage.setString('userData', jsonEncode(userData));
                                    //print(userData);
                                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(userData)));
                                  }else{
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                      backgroundColor: Colors.orange,
                                      content: Text(
                                        'Ten adres email jest zajęty',
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
                                    'Musisz wypełnić pole Email',
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
                        ],
                    ),
                )]
            ),
          ),
      ),
    );
  }
}