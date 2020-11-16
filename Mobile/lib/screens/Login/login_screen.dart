import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/goBackButton.dart';

class Login extends StatelessWidget {

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
                          Image.asset("assets/user.png"),
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
                          SizedBox(height: size.height*0.05),
                          RoundedButton(
                            text: "Zaloguj się",
                            color: Colors.orange.withOpacity(0.95),
                            textColor: Colors.white,
                            onPress: (){
                              print(usernameController.text);
                              print(passwordController.text);
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