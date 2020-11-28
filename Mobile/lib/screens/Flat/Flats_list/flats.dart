import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planus/components/AddFlatCard.dart';
import 'package:planus/components/FlatCard.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/screens/Flat/Flats_list/list_flats_screen.dart';
import 'package:planus/services/apiController.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Flats extends StatefulWidget {
  
  final Map response;

  Flats(this.response);

  @override
  _FlatsState createState() => _FlatsState();
}

int flats_count = 0;
List flats;
List<FlatInfo> flatCard;
bool _isLoading = false;

class _FlatsState extends State<Flats> {

  sendData(id) async{
      var api = new Api();
      var response = await api.listFlats(id);
      
      setState(() {
        _isLoading = true;
        if(response['statusCode']==200){
          flats = response['body']['data'];
          flats_count = flats.length;
          flatCard = [];
          

          if(flats_count!=0){
            for(int i=0;i<flats_count;i++){
              flatCard.add(FlatInfo(id_user: widget.response['id']));
              flatCard[i].parseData(flats[i]);
            }
          }
        }
        _isLoading = false;
      });
    }
  
  @override
  void initState() {
    sendData(widget.response['id']);
    super.initState();

    Timer.run(() {
      Navigator.of(context).pushReplacementNamed("/choice");
    });
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;

    if(_isLoading){
        return Scaffold(
          backgroundColor: Colors.orange,
          body: Center(
            child: SpinKitPulse(
              color: Colors.white,
              size: 100.0,
            ),
          )
        );
    }else{
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
                        if(flats_count==1)FlatCard(
                          flat_name: (flatCard==null) ? 'Loading...' : flatCard[0].name, 
                          size: size.width*0.5, 
                          image: (flatCard==null) ? 'https://cdn.discordapp.com/attachments/635152661137850390/781908048045932544/mieszkanie.png' : flatCard[0].image
                        ),
                        
                        if(flats_count>1) FlatCard(
                          flat_name: (flatCard==null) ? 'Loading...' : flatCard[1].name,
                          size: size.width*0.5, 
                          image: (flatCard==null) ? 'https://cdn.discordapp.com/attachments/635152661137850390/781908048045932544/mieszkanie.png' : flatCard[1].image
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
                            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => ListFlats(flatCard)));
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
}

class FlatInfo{

  int id_user;
  Map json;

  FlatInfo({
    this.id_user,
  });

  int id_owner;

  String name;
  int price;
  String image;
  int area;
  int rooms;
  String localization;

  int settlement_day;
  int billing_period;
  double cold_water;
  double hot_water;
  double heating_year;
  double gas;
  double electricity;
  double rubbish;
  double internet;
  double tv;
  double phone;

  void parseData(Map response){
    id_owner = response['user_id'];

    name = response['name'];
    image = response['image'];
  }
}