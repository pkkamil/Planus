import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';

class ChangePassword extends StatelessWidget {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  @override
  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
  }
  
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
                            controller: usernameController,
                            width: size.width*0.7,
                            placeholder: "Obecne hasło",
                            icon: Icons.lock,
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
                          RoundedInput(
                            controller: repeatPasswordController,
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
                            onPress: (){
                              print(usernameController.text);
                              print(passwordController.text);
                              print(repeatPasswordController.text);
                              Navigator.pop(context);
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