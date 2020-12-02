import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planus/components/AddFlatCard.dart';
import 'package:planus/components/FlatCard.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/screens/choice/choice_screen.dart';

class ListFlats extends StatelessWidget {
  
  final List response;

  const ListFlats(this.response);


  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
          body: Container(
            height: size.height,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(30, 40, 0, 20),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 24,
                      ),
                      children: [
                        TextSpan(text: "Twoje "),
                        TextSpan(text: "mieszkania", style: TextStyle(color: Colors.orange)),
                        TextSpan(text: ":"),
                      ]
                    ),
                  )
                ),
                Container(
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            for(int i=0;i<response.length;i+=2) Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatCard(
                                  flat_name: response[i].name,
                                  size: size.width*0.4,
                                  image: response[i].image,
                                  marginL: 10.0,
                                  marginR: 10.0,
                                  marginB: 10.0,
                                  marginT: 10.0,
                                  fontSize: 15.0,
                                  flatData: response[i],
                                ),
                                (i+1==response.length) ? AddFlatCard(size: size.width*0.4,marginL: 10.0,marginR: 10.0, user_id: response[0].id_user,) : FlatCard(flat_name: response[i+1].name, size: size.width*0.4, image: response[i+1].image,marginL: 10.0, marginR: 10.0, fontSize: 15.0,marginB: 10.0, marginT: 10.0,flatData: response[i+1])
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: size.height*0.02),
                      if(response.length%2==0) Column(
                        children: [
                          RoundedButton(
                            width: size.width*0.7,
                            onPress: () {
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Choice(response[0].id_user)));
                            },
                            color: Colors.white,
                            textColor: Colors.orange,
                            text: "Dodaj mieszkanie",
                          ),
                          SizedBox(height: size.height*0.05)
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
    );
  }
}