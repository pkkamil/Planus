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

class ChangeName extends StatelessWidget {

  final FlatInfo flatData;

  ChangeName(this.flatData);

  final usernameController = TextEditingController();
  Map data;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose(){
    usernameController.dispose();
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
                            "assets/Name.svg",
                            width: size.width*0.6,
                          ),
                          SizedBox(height:size.height*0.03),
                          Text(
                            "Przedstaw się",
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 24
                            ),
                          ),
                          SizedBox(height:size.height*0.05),
                          RoundedInput(
                            controller: usernameController,
                            width: size.width*0.7,
                            placeholder: "Imie",
                            color: Colors.white,
                            textColor: Colors.black,
                            iconColor: Colors.black,
                          ),
                          SizedBox(height: size.height*0.05),
                          RoundedButton(
                            text: "Zmień imie",
                            color: Colors.orange.withOpacity(0.95),
                            textColor: Colors.white,
                            onPress: () async{
                              if(usernameController.text!=null && usernameController.text.length>0){
                                data = {
                                'user_id': flatData.id_user,
                                'name': usernameController.text
                                };
                                
                                var api = new Api();
                                var response = await api.changeName(data);
                                
                                if(response['Message']=='OK'){
                                  SharedPreferences localStorage = await SharedPreferences.getInstance();
                                  Map userData = jsonDecode(localStorage.getString('userData'));
                                  
                                  userData['name'] = usernameController.text;
                                  localStorage.setString('userData', jsonEncode(userData));
                                  
                                  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(userData)));
                                }else{
                                  _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                  backgroundColor: Colors.orange,
                                  content: Text(
                                    response,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                    )
                                  )
                                );
                                }
                                
                              }else{
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                  backgroundColor: Colors.orange,
                                  content: Text(
                                    'Musisz wypełnić pole Imie',
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