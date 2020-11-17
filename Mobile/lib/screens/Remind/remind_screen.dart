import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';

class Remind extends StatelessWidget {

  final usernameController = TextEditingController();

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
                          SizedBox(height:size.height*0.03),
                          Text(
                            "Odzyskaj hasło",
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 24
                            ),
                          ),
                          SizedBox(height:size.height*0.05),
                          RoundedInput(
                            controller: usernameController,
                            width: size.width*0.7,
                            icon: Icons.email,
                            placeholder: "E-mail",
                            color: Colors.white,
                            textColor: Colors.black,
                            iconColor: Colors.black,
                          ),
                          SizedBox(height: size.height*0.05),
                          RoundedButton(
                            text: "Przypomnij",
                            color: Colors.orange.withOpacity(0.95),
                            textColor: Colors.white,
                            onPress: (){
                              print(usernameController.text);
                            },
                            width: size.width*0.7
                          ),
                          /*
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
                          */
                    
                        ],
                    ),
                )]
            ),
          ),
      ),
    );
  }
}