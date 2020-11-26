import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';
import 'package:planus/services/adresses.dart';

class Login extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


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
      
      if(response['email'].toLowerCase()==data['email'].toLowerCase()){
        Navigator.popAndPushNamed(context, '/flats');
        //zapisać w pamięci do autlogowania
      }else{
        print(response['message']);
      }
    }
    
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
                              Map data = {
                                'email': emailController.text,
                                'password': passwordController.text
                              };
                              sendData(data);
                              //Jezeli nie ma zweryfikowanego maila popandpushnamed do verificate
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
      ),
    );
  }
}