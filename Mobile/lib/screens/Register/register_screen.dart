import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/body.dart';
import 'package:bordered_text/bordered_text.dart';

class Register extends StatelessWidget {

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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        image: AssetImage('assets/ekran_glowny_tlo.png'),
        child: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: RoundedButton(
                        text: "Wróć",
                        color: Colors.orange.withOpacity(0.95),
                        onPress: (){
                          Navigator.pushReplacementNamed(context, '/welcome');
                        },
                        width: size.width*0.2,
                        fontsize: 14.0,
                        vertical: 0.5,
                        horizontal: 1.0,
                        radius: 30.0,
                        marginV: 40.0,
                        marginH: 20.0,
                      ),
                    ),
                    Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height*0.1),
                            BorderedText(
                              strokeWidth: 2,
                              strokeColor: Colors.black,
                              child: Text(
                                  "Rejestracja",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    
                                    fontSize: 48
                                ),
                              ),
                            ),
                            SizedBox(height:size.height*0.1),
                            RoundedInput(
                              controller: usernameController,
                              width: size.width*0.7,
                              placeholder: "E-mail",
                              color: Colors.orange.withOpacity(0.95),
                              textColor: Colors.black,
                              iconColor: Colors.black,
                            ),
                            RoundedInput(
                              controller: passwordController,
                              width: size.width*0.7,
                              placeholder: "Hasło",
                              password: true,
                              color: Colors.orange.withOpacity(0.95),
                              textColor: Colors.black,
                              iconColor: Colors.black,
                              icon: Icons.lock,
                            ),
                            RoundedInput(
                              controller: repeatPasswordController,
                              width: size.width*0.7,
                              placeholder: "Potwierdź hasło",
                              password: true,
                              color: Colors.orange.withOpacity(0.95),
                              textColor: Colors.black,
                              iconColor: Colors.black,
                              icon: Icons.lock,
                            ),
                            SizedBox(height: size.height*0.05),
                            RoundedButton(
                              text: "Zaloguj się",
                              color: Colors.orange.withOpacity(0.95),
                              onPress: (){
                                print(usernameController.text);
                                print(passwordController.text);
                                print(repeatPasswordController.text);
                              },
                              width: size.width*0.7
                            )          
                          ],
                      ),
                  )]
              ),
            ),
        ),
      ),
    );
  }
}