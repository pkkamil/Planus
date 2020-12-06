import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DeleteAccount extends StatelessWidget {
  
  final FlatInfo flatData;

  DeleteAccount(this.flatData);

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                          fontSize: 18
                        ),
                      ),
                      SizedBox(height: size.height*0.03),
                      RoundedButton(
                        text: "Tak, usuń konto",
                        color: Colors.orange.withOpacity(0.95),
                        textColor: Colors.white,
                        onPress: () async{
                          var api = new Api();
                          var response = await api.deleteAccount(flatData.id_user);

                          print(response);

                          if(response['Message']=='OK'){
                            SharedPreferences localStorage = await SharedPreferences.getInstance();
                            localStorage.setString('userData', null);

                            Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                            Navigator.pushNamed(context, '/farawell');
                          }
                        },
                        width: size.width*0.7
                      ),             
                    ],
                ),
            )]
        ),
      ),
    );
  }
}