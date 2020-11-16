import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/body.dart';
import 'package:bordered_text/bordered_text.dart';

class Remind extends StatelessWidget {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
        height: size.height,
        image: AssetImage('assets/ekran_glowny_tlo.png'),
        child: SingleChildScrollView(
            child: Container(
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
                                  "Przypomnienie hasła",
                                  textAlign: TextAlign.center,
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
                            SizedBox(height: size.height*0.05),
                            RoundedButton(
                              text: "Przypomnij",
                              color: Colors.orange.withOpacity(0.95),
                              onPress: (){
                                print(usernameController.text);
                                print(passwordController.text);
                              },
                              width: size.width*0.7
                            ),
                            SizedBox(height: size.height*0.04),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                              child: BorderedText(
                                strokeWidth: 2,
                                strokeColor: Colors.black,
                                child: Text(
                                    "Zaloguj się",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                              ),
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