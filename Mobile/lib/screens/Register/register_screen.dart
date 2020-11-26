import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final repeatPasswordController = TextEditingController();

  
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Builder(
        builder: (context) { return SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
                child: Stack(
                  children: [
                    GoBackButton(),
                    Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height*0.05),
                            SvgPicture.asset(
                              "assets/Register.svg",
                              width: size.width*0.6,
                            ),
                            SizedBox(height:size.height*0.03),
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
                            SizedBox(height: size.height*0.03),
                            RoundedButton(
                              text: "Zarejestruj się",
                              textColor: Colors.white,
                              color: Colors.orange.withOpacity(0.95),
                              onPress: (){
                                //wykrycie czy wszystkie pola sa wypelniona plus sprawdzanie poprawnosci email
                                
                                if(emailController.text == '' || passwordController.text == '' || repeatPasswordController.text == ''){
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
                                  if(passwordController.text.length<8){
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.orange,
                                          content: Text(
                                            "Hasło powinno mieć minimum 8 znaków",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18
                                            ),
                                          )
                                        )
                                    );
                                  }else{
                                    bool isEmail = EmailValidator.validate(emailController.text);
                                    if(passwordController.text==repeatPasswordController.text){
                                      if(isEmail){                                    
                                        Navigator.popAndPushNamed(context, '/introduce', arguments: {
                                        'email': emailController.text,
                                        'password': passwordController.text,
                                        'password_confirmation':repeatPasswordController.text
                                        });
                                        
                                      }else{
                                        Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.orange,
                                          content: Text(
                                            "Niepoprawny adres e-mail",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18
                                            ),
                                          )
                                        )
                                        );
                                      }
                                      
                                    }else{
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.orange,
                                          content: Text(
                                            "Hasła nie zgadzają się",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18
                                            ),
                                          )
                                        )
                                      );
                                    } 
                                  }
                                }
                              },
                              width: size.width*0.7
                            ),
                            SizedBox(height: size.height*0.03),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                              child: Text(
                                  "Posiadasz już konto?",
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
