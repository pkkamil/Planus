import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planus/components/AddFlatCard.dart';
import 'package:planus/components/FlatCard.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/services/apiController.dart';

class Flats extends StatefulWidget {
  
  final Map response;

  Flats(this.response);

  @override
  _FlatsState createState() => _FlatsState();
}

int flats_count = 1;
String image = "assets/mieszkanie.png";
String flat_name = "Loading...";
List flats;

class _FlatsState extends State<Flats> {
  
  @override
  Widget build(BuildContext context) {

    sendData(id) async{
      var api = new Api();
      var response = await api.listFlats(id);

      setState(() {
        flats = response['data'];
        flats_count = flats.length;
      });
      if(flats_count==0){Navigator.popAndPushNamed(context, '/choice');}
    }

    sendData(widget.response['id']);


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
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 50,
                    left: 30,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(text: "Witaj, "),
                          TextSpan(text: widget.response['name'], style: TextStyle(color: Colors.orange)),
                          TextSpan(text: "!"),
                        ]
                      ),
                    )
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height*0.1),
                        FlatCard(
                          flat_name: flat_name, 
                          size: size.width*0.5, 
                          image: image
                        ),
                        if(flats_count>1) FlatCard(
                          flat_name: flat_name, 
                          size: size.width*0.5, 
                          image: image
                        ),
                        if(flats_count==1) AddFlatCard(
                          size: size.width*0.5
                        ),
                        if(flats_count==2)RoundedButton(
                          width: size.width*0.7,
                          horizontal: 0.0,
                          onPress: () {
                            Navigator.pushNamed(context, '/choice');
                          },
                          text: "Dodaj mieszkanie",
                        ),
                        if(flats_count>2)RoundedButton(
                          horizontal: 0.0,
                          width: size.width*0.7,
                          color: Colors.white,
                          textColor: Colors.orange,
                          onPress: () {
                            Navigator.popAndPushNamed(context, '/listflats');
                          },
                          text: "Zobacz wszystkie",
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
