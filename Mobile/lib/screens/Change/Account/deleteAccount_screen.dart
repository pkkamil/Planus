import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';

class DeleteAccount extends StatelessWidget {

  
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
                          SizedBox(height: size.height*0.05),
                          SvgPicture.asset(
                            "assets/deleteAccount.svg",
                            width: size.width*0.6,
                          ),
                          SizedBox(height:size.height*0.03),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 24,
                              ),
                              children: [
                                TextSpan(text: "Próbujesz usunąć swoje "),
                                TextSpan(text: "konto", style: TextStyle(color: Colors.orange)),
                                TextSpan(text: "."),
                              ]
                            ),
                          ),
                          Text(
                            "Czy jesteś pewny?",
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 24
                            ),
                          ),
                          SizedBox(height: size.height*0.03),
                          RoundedButton(
                            text: "Tak, usuń konto",
                            color: Colors.orange.withOpacity(0.95),
                            textColor: Colors.white,
                            onPress: (){
                              Navigator.popAndPushNamed(context, '/flats');
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