import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/goBackButton.dart';

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

      body: SingleChildScrollView(
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
                          SizedBox(height: size.height*0.1),
                          Image.asset("assets/user.png"),
                          SizedBox(height:size.height*0.03),
                          RoundedInput(
                            controller: usernameController,
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
                          SizedBox(height: size.height*0.05),
                          RoundedButton(
                            text: "Zaloguj się",
                            textColor: Colors.white,
                            color: Colors.orange.withOpacity(0.95),
                            onPress: (){
                              print(usernameController.text);
                              print(passwordController.text);
                              print(repeatPasswordController.text);
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
      ),
    );
  }
}