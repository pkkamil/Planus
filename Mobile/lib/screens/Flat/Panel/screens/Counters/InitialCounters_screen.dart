import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlatInfo flatData;
bool _isLoading;

class InitialCounters extends StatefulWidget {
  
  final int user_id;
  final int apartment_id;
  InitialCounters(this.user_id,this.apartment_id);

  @override
  _InitialCountersState createState() => _InitialCountersState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _InitialCountersState extends State<InitialCounters> {

  double coldWaterCountController = 0.0;
  double hotWaterCountController = 0.0;
  double electricityCountController = 0.0;
  double gasCountController = 0.0;

  double coldWaterCount;
  double hotWaterCount;
  double gasCount;
  double electricityCount;

  List counters;
  FlatInfo flatData;

  void _getFlatData(apartment_id,user_id) async{
    var api = new Api();
    var response = await api.listFlats(user_id);
    //print(response);
    if(response['statusCode']==200){
      List flats = response['body']['data'];
      int flats_count = flats.length;

      for(int i=0;i<flats_count;i++){
        if(flats[i]['id_apartment']==apartment_id){
          setState(() {
            flatData = FlatInfo(id_user: user_id);
            flatData.parseData(flats[i]);
          });
          //print(flats[i]);

        }
      }
      setState(() {
        _isLoading = false;
      });

      if(flatData.cold_water == 0.0 && flatData.hot_water==0.0 && flatData.gas==0.0 && flatData.electricity==0.0){
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        Map response = jsonDecode(localStorage.getString('userData'));

        Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
      }
      }
  }

  @override
  void initState() {
    _getFlatData(widget.apartment_id,widget.user_id);
    setState(() {
      _isLoading = true;
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    
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
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
            children:[ 
            Container(
            child: Stack(
              children: [
                if(flatData.hot_water>0 || flatData.cold_water>0 || flatData.electricity>0 || flatData.gas>0)Positioned(
                  top: 50,
                  left: 30,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 24,
                      ),
                      children: [
                        TextSpan(text: "Wprowadź "),
                        TextSpan(text: "liczniki", style: TextStyle(color: Colors.orange)),
                      ]
                    ),
                  )
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: size.height*0.15),
                      if(flatData.cold_water>0) RoundedInput(
                        isNumber: true,
                        width: size.width*0.8,
                        placeholder: "Stan licznika wody zimnej [1m\u00B3]",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.grey[900],
                        icon: Icons.opacity, //inna
                        onChanged: (val) {
                          setState(() {
                            coldWaterCountController = double.parse(val);
                          });
                        },
                      ),
                      if(flatData.hot_water>0) RoundedInput(
                        isNumber: true,
                        width: size.width*0.8,
                        placeholder: "Stan licznika wody ciepłej [1m\u00B3]",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.grey[900],
                        icon: Icons.waves,
                        onChanged: (val) {
                          setState(() {
                            hotWaterCountController = double.parse(val);
                          });
                        },
                      ),
                      if(flatData.gas>0) RoundedInput(
                        isNumber: true,
                        width: size.width*0.8,
                        placeholder: "Stan licznika gazu [kWh]",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.grey[900],
                        icon: CupertinoIcons.burst_fill,
                        onChanged: (val) {
                          setState(() {
                            gasCountController = double.parse(val);
                          });
                        },
                      ),
                      if(flatData.electricity>0) RoundedInput(
                        isNumber: true,
                        width: size.width*0.8,
                        placeholder: "Stan licznika prądu [kWh]",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.grey[900],
                        icon: Icons.flash_on,
                        onChanged: (val) {
                          setState(() {
                            electricityCountController = double.parse(val);
                          });
                        },
                      ),
                    ],
                  ),
                )
              ]
            ),
          ),
          SizedBox(height: size.height*0.03),
          
          
          SizedBox(height: size.height*0.05),
          if(flatData.hot_water>0 || flatData.cold_water>0 || flatData.electricity>0 || flatData.gas>0)RoundedButton(
            text: "Zapisz liczniki",
            width: size.width*0.7,
            color: Colors.white,
            textColor: Colors.orange,
            onPress: () async {
              var api = new Api();
              Map data = {
                'id_apartment':flatData.id_apartment,
                'cold_water': coldWaterCountController,
                'hot_water': hotWaterCountController,
                'gas': gasCountController,
                'electricity': electricityCountController,
              };
              //initial
              var response = await api.initialCounters(data);

              if(response['message']=='OK'){
                SharedPreferences localStorage = await SharedPreferences.getInstance();
                Map response = jsonDecode(localStorage.getString('userData'));

                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
              }else{
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.orange,
                      content: Text(
                        response['message'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18
                        ),
                      )
                  )
                );
              }
            },
          ),
          SizedBox(height: size.height*0.05)
          ]
        ),
      ),
    );}
  }
}

