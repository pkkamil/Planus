import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class Farawell extends StatelessWidget {

  pushToWelcome (context) async{
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, '/welcome');
  }
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;
    pushToWelcome(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            height: size.height,
              child: Stack(
                children: [
                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height*0.05),
                          SvgPicture.asset(
                            "assets/Farawell.svg",
                            width: size.width*0.7,
                          ),
                          SizedBox(height:size.height*0.03),
                          Column(
                            children: [
                              Container(
                                width: size.width*0.5,
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Żegnaj,", 
                                    style: TextStyle(fontSize: 24),
                                    textAlign: TextAlign.left,
                                    ),
                                    Container(
                                        child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.grey[900],
                                            fontSize: 36,
                                          ),
                                          children: [
                                            TextSpan(text: "przyjacielu", style: TextStyle(color: Colors.orange)),
                                            TextSpan(text: "!", style: TextStyle(fontSize: 56)),
                                          ]
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),         
                                  ],
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