import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planus/components/AddFlatCard.dart';
import 'package:planus/components/FlatCard.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/screens/Flat/Flats_list/list_flats_screen.dart';
import 'package:planus/screens/choice/choice_screen.dart';
import 'package:planus/services/apiController.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Flats extends StatefulWidget {
  
  final Map response;

  Flats(this.response);

  @override
  _FlatsState createState() => _FlatsState();
}

int flats_count = 0;
List flats;
List<FlatInfo> flatCard;
bool _isLoading = true;

class _FlatsState extends State<Flats> {

  sendData(id) async{
      var api = new Api();
      var response = await api.listFlats(id);

      if(response['statusCode']==500){
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('userData', null);
        Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
        Navigator.pushNamed(context, '/welcome');
      }

      setState(() {
        _isLoading = true;
        if(response['statusCode']==200){
          flats = response['body']['data'];
          flats_count = flats.length;
          if(flats_count==null){flats_count=0;};
          flatCard = [];
          

          if(flats_count!=0){
            for(int i=0;i<flats_count;i++){
              flatCard.add(FlatInfo(id_user: widget.response['id']));
              flatCard[i].parseData(flats[i]);
            }
          }
        }
      });
      //print(flatCard);
      _isLoading = false;
    }

  void setupData() async{
    await sendData(widget.response['id']);
    if(flats_count==0 && _isLoading==false){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Choice(widget.response['id'])));
    }
  }

  @override
  void initState() {
    setupData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;

    //if(flats_count==0){
      //Navigator.pushReplacementNamed(context, '/choice');
    //}

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
                        SizedBox(height: size.height*0.15),
                        if(flats_count>=1)FlatCard(
                          flat_name: (flatCard==null) ? 'Loading...' : flatCard[0].name, 
                          size: size.width*0.5, 
                          image: (flatCard==null) ? 'https://cdn.discordapp.com/attachments/635152661137850390/781908048045932544/mieszkanie.png' : flatCard[0].image,
                          flatData: (flatCard==null) ? 'Loading...' : flatCard[0],
                        ),
                        
                        if(flats_count>1) FlatCard(
                          flat_name: (flatCard==null) ? 'Loading...' : flatCard[1].name,
                          size: size.width*0.5, 
                          image: (flatCard==null) ? 'https://cdn.discordapp.com/attachments/635152661137850390/781908048045932544/mieszkanie.png' : flatCard[1].image,
                          flatData: (flatCard==null) ? 'Loading...' : flatCard[1],
                        ),
                        
                        if(flats_count==1) AddFlatCard(
                          size: size.width*0.5,
                          user_id: widget.response['id'],
                        ),
                        if(flats_count==2)RoundedButton(
                          width: size.width*0.7,
                          horizontal: 0.0,
                          onPress: () {
                            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Choice(widget.response['id'])));
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
  int id_apartment;
  bool isPublic;

  String name;
  double price;
  String image;
  int area;
  int rooms;
  String localization;

  int settlement_day;
  int billing_period;
  double cold_water;
  double hot_water;
  double heating;
  double gas;
  double electricity;
  double rubbish;
  double internet;
  double tv;
  double phone;

  String invite_code;

  DateTime created_at;
  DateTime updated_at;

  double summary = 0.0;

  void parseData(Map response){
    created_at = DateTime.parse(response['created_at']);
    updated_at = DateTime.parse(response['updated_at']);

    id_owner = response['user_id'];
    id_apartment = response['id_apartment'];

    isPublic = response['public']==1;

    invite_code = response['invite_code'];

    name = response['name'];
    if(response[image]==null){
      response[image]=='https://cdn.discordapp.com/attachments/635152661137850390/781908048045932544/mieszkanie.png';
    }
    image = response['image'];
    (image[0] == 'h') ? image : image='http://planus.me'+image;
    area = response['area'];
    rooms = response['rooms'];
    localization = response['localization'];
    
    List responses = ['price','settlement_day', 'billing_period', 'cold_water', 'hot_water', 'heating', 'gas', 'electricity', 'rubbish', 'internet','tv', 'phone'];
    for(int i=0; i<responses.length; i++){
      (response[responses[i]]==null) ? response[responses[i]]='0' : response[responses[i]]=response[responses[i]].toString();
    }
    price = double.parse(response['price']);
    settlement_day = int.parse(response['settlement_day']);
    billing_period = int.parse(response['billing_period']);
    cold_water = double.parse(response['cold_water']);
    hot_water = double.parse(response['hot_water']);
    heating = double.parse(response['heating']);
    gas = double.parse(response['gas']);
    electricity = double.parse(response['electricity']);
    rubbish = double.parse(response['rubbish']);
    internet = double.parse(response['internet']);
    tv = double.parse(response['tv']);
    phone = double.parse(response['phone']);


    List itemsToSum = ['price', 'rubbish', 'internet', 'tv', 'phone'];
    for(int i=0;i<itemsToSum.length;i++){
      summary+=double.parse(response[itemsToSum[i]]);
    }
  }
}