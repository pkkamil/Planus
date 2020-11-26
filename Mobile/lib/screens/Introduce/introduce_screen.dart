import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:flutter/services.dart';
import 'package:planus/screens/Verificate/verification_screen.dart';
import 'package:planus/services/apiController.dart';

String name;
Map registerData = {};

class Introduce extends StatefulWidget {

  @override
  _IntroduceState createState() => _IntroduceState();
}

class _IntroduceState extends State<Introduce> {
  final usernameController = TextEditingController();

  @override
  void dispose(){
    usernameController.dispose();
    super.dispose();
  }

  static GlobalKey<FormFieldState<String>> nameKey = new GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    sendData(data) async{
      var api = new Api();
      var response = await api.register(data);
      
      if(response['message']=='OK'){
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Verificate(registerData['email'],registerData['password'])));
      }else{
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Colors.orange,
            content: Text(
              response['errors']['email'][0],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18
            ),
            )
          )
        );
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    }

    registerData = ModalRoute.of(context).settings.arguments;

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Builder(
        builder: (context) { return SingleChildScrollView(
            child: Container(
              height: size.height,
                child: Stack(
                  children: [
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
                              key: nameKey,
                              controller: usernameController,
                              width: size.width*0.7,
                              placeholder: "Imie",
                              color: Colors.white,
                              textColor: Colors.black,
                              iconColor: Colors.black,
                            ),
                            SizedBox(height: size.height*0.05),
                            RoundedButton(
                              text: "Zapisz",
                              color: Colors.orange.withOpacity(0.95),
                              textColor: Colors.white,
                              onPress: (){
                                if(usernameController.text.length==0){
                                 Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.orange,
                                      content: Text(
                                        "Musisz wypełnić to pole",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                      )
                                    )
                                  );
                                }else{
                                Map data = {
                                  "name":usernameController.text,
                                  "email":registerData['email'],
                                  "password": registerData['password'],
                                  "password_confirmation": registerData['password_confirmation']
                                };
                                sendData(data); 
                                }
                              },
                              width: size.width*0.7
                            ),                  
                          ],
                      ),
                  )]
              ),
            ),
        );}
      ),
      key: _scaffoldKey,
    );
  }
}
